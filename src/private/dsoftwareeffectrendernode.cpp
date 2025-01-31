/*
 * Copyright (C) 2022 UnionTech Technology Co., Ltd.
 *
 * Author:     Chen Bin <chenbin@uniontech.com>
 *
 * Maintainer: Chen Bin <chenbin@uniontech.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "dsoftwareeffectrendernode.h"

#include <private/qsgadaptationlayer_p.h>
#include <private/qsgsoftwarepixmaptexture_p.h>
#if QT_VERSION < QT_VERSION_CHECK(5, 14, 0)
#include <private/qsgtexture_p.h>
#else
#include <private/qsgplaintexture_p.h>
#endif

#include <QSGTextureProvider>
#include <QQuickWindow>
#include <QQuickItem>

DQUICK_BEGIN_NAMESPACE

static inline bool _d_isSoftwarePixmapTexture(QSGTexture *texture) {
#if defined(QT_NAMESPACE)
#define NAMESPACE_STR1(NAME) #NAME"::QSGSoftwarePixmapTexture"
#define NAMESPACE_STR(R) NAMESPACE_STR1(R)
#define PixmapTextureClassName NAMESPACE_STR(QT_NAMESPACE)
#else
#define PixmapTextureClassName "QSGSoftwarePixmapTexture"
#endif
    return texture->inherits(PixmapTextureClassName);
}

DSoftwareEffectRenderNode::DSoftwareEffectRenderNode(QSGTextureProvider *sourceProvider)
    : m_sourceProvider(sourceProvider)
{
    setFlag(QSGNode::UsePreprocess, true);
    m_sourceImage = updateCachedImage(m_sourceProvider);
    if (m_sourceProvider) {
        connect(m_sourceProvider, &QSGTextureProvider::textureChanged
                , this, &DSoftwareEffectRenderNode::onRenderTextureChanged, Qt::DirectConnection);
    }
}

void DSoftwareEffectRenderNode::preprocess()
{
    if (m_sourceProvider && updateTexture(m_sourceProvider->texture()))
        markChanged();
}

void DSoftwareEffectRenderNode::sync(QQuickItem *item)
{
    m_window = item->window();
    bool antialiasing = item->antialiasing();
    bool smooth = item->smooth();
    bool changed = false;
    if (m_antialiasing != antialiasing) {
        m_antialiasing = antialiasing;
        changed = true;
    }
    if (m_smooth != smooth) {
        m_smooth = smooth;
        changed = true;
    }
    if (changed)
        m_changed = true;
}

void DSoftwareEffectRenderNode::render(const QSGRenderNode::RenderState *state)
{
    if (Q_UNLIKELY(!m_window))
        return;

    QSGRendererInterface *rif = m_window->rendererInterface();
    QPainter *p = static_cast<QPainter *>(rif->getResource(m_window, QSGRendererInterface::PainterResource));
    Q_ASSERT(p);
    const QRegion *clipRegion = state->clipRegion();
    if (Q_UNLIKELY(clipRegion && !clipRegion->isEmpty()))
        p->setClipRegion(*clipRegion, Qt::ReplaceClip);
    p->setTransform(matrix()->toTransform());
    p->setOpacity(inheritedOpacity());
    p->setRenderHint(QPainter::Antialiasing, m_antialiasing);
    p->setRenderHint(QPainter::SmoothPixmapTransform, m_smooth);

    if (m_cached && !m_changed)
        return renderImpl(p);

    m_renderDevice = process(m_sourceImage, p->renderHints());
    m_changed = false;
    renderImpl(p);
}

void DSoftwareEffectRenderNode::setCached(bool cached)
{
    if (m_cached == cached)
        return;
    m_cached = cached;
    markDirty(QSGNode::DirtyMaterial);
}

bool DSoftwareEffectRenderNode::cached() const
{
    return m_cached;
}

void DSoftwareEffectRenderNode::markChanged()
{
    m_changed = true;
    markDirty(QSGNode::DirtyMaterial);
}

void DSoftwareEffectRenderNode::onRenderTextureChanged()
{
    auto provider = qobject_cast<QSGTextureProvider *>(sender());
    if (provider != m_sourceProvider)
        return;

    QImage sourceImage = updateCachedImage(m_sourceProvider);
    if (sourceImage != m_sourceImage) {
        m_sourceImage = sourceImage;
        markChanged();
    }
}

QImage DSoftwareEffectRenderNode::updateCachedImage(QSGTextureProvider *provider)
{
    if (provider) {
        auto texture = provider->texture();
        if (auto plainTexture = qobject_cast<QSGPlainTexture*>(texture))
            return plainTexture->image();

        if (QSGLayer *layer = qobject_cast<QSGLayer*>(texture))
            return layer->toImage();

        if (_d_isSoftwarePixmapTexture(texture)) {
            auto pixmapTexture = static_cast<QSGSoftwarePixmapTexture *>(texture);
            return pixmapTexture->pixmap().toImage();
        }
    }

    static QImage nullImage;
    return nullImage;
}

bool DSoftwareEffectRenderNode::updateTexture(QSGTexture *texture)
{
    bool dirty = false;
    QSGLayer *t = qobject_cast<QSGLayer *>(texture);
    if (t) {
        t->setMirrorVertical(false);
        dirty = t->updateTexture();
    }
    return dirty;
}

void DSoftwareEffectRenderNode::renderImpl(QPainter *p)
{
    p->drawImage(rect(), m_renderDevice, m_renderDevice.rect());
}

DQUICK_END_NAMESPACE
