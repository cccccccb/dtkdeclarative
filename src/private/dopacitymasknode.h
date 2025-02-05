/*
 * Copyright (C) 2022 UnionTech Technology Co., Ltd.
 *
 * Author:     xiaoyaobing <xiaoyaobing@uniontech.com>
 *
 * Maintainer: xiaoyaobing <xiaoyaobing@uniontech.com>
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

#ifndef DOPACITYMASKNODE_H
#define DOPACITYMASKNODE_H

#include "dsoftwareeffectrendernode.h"

#include <dtkdeclarative_global.h>

DQUICK_BEGIN_NAMESPACE

class DSoftwareOpacityMaskNode : public DSoftwareEffectRenderNode
{
    Q_OBJECT
public:
    explicit DSoftwareOpacityMaskNode(QSGTextureProvider *source, QSGTextureProvider *maskSource);
    void setInvert(bool invert);

    QRectF rect() const override { return QRect(0, 0, static_cast<int>(m_width), static_cast<int>(m_height)); }
    void sync(QQuickItem *item) override;
    QImage process(const QImage &sourceImage, QPainter::RenderHints hints) override;
    void preprocess() override;

private Q_SLOTS:
    void onMaskTextureChanged();

private:
    bool m_invert = false;
    qreal m_width = 0;
    qreal m_height = 0;
    QQuickItem *m_item = nullptr;
    QImage m_maskImage;
    QPointer<QSGTextureProvider> m_maskProvider = nullptr;

};

DQUICK_END_NAMESPACE

#endif // DOPACITYMASKNODE_H
