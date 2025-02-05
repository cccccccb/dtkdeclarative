/*
 * Copyright (C) 2021 ~ 2022 UnionTech Technology Co., Ltd.
 *
 * Author:     JiDe Zhang <zhangjide@deepin.org>
 *
 * Maintainer: JiDe Zhang <zhangjide@deepin.org>
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
#ifndef DSOFTWAREBLURIMAGENODE_H
#define DSOFTWAREBLURIMAGENODE_H

#include <dtkdeclarative_global.h>
#include <QSGRenderNode>
#include <QImage>
#include <QPointer>

QT_BEGIN_NAMESPACE
class QQuickItem;
class QSGTexture;
class QSGPlainTexture;
#ifndef QT_NO_OPENGL
class QOpenGLShaderProgram;
class QOpenGLFramebufferObject;
class QOpenGLBuffer;
#endif
QT_END_NAMESPACE

DQUICK_BEGIN_NAMESPACE

class DSGBlurNode : public QSGRenderNode
{
public:
    DSGBlurNode(QQuickItem *owner);

    typedef void(*RenderCallback)(DSGBlurNode *node, void *data);
    void setRenderCallback(RenderCallback callback, void *data);
    inline void doRenderCallback() {
        if (!m_renderCallback)
            return;
        m_renderCallback(this, m_callbackData);
    }

    inline void setOffscreen(bool offscreen) {
        if (m_offscreen == offscreen)
            return;
        m_offscreen = offscreen;
        markDirty(DirtyMaterial);
    }

    virtual void setTexture(QSGTexture *texture);
    inline QSGTexture *texture() const
    { return m_texture;}
    virtual bool writeToTexture(QSGPlainTexture *targetTexture) const;
    virtual void setRadius(qreal radius);
    void setSourceRect(const QRectF &source);
    void setRect(const QRectF &target);
    void setDisabledOpaqueRendering(bool disabled);
    void setBlendColor(const QColor &color);
    void setFollowMatrixForSource(bool on);

    RenderingFlags flags() const override;
    QRectF rect() const override;

protected:
    RenderCallback m_renderCallback = nullptr;
    void *m_callbackData = nullptr;
    bool m_offscreen = false;

    QPointer<QQuickItem> m_item;
    QSGTexture *m_texture = nullptr;
    qreal m_radius = 0;
    QRectF m_sourceRect;
    QRectF m_targetRect;
    QColor m_blendColor = Qt::transparent;
    bool m_disabledOpaqueRendering = false;
    bool m_followMatrixForSource = false;
};

class DSoftwareBlurImageNode : public DSGBlurNode
{
public:
    DSoftwareBlurImageNode(QQuickItem *owner);

private:
    void render(const RenderState *state) override;
    void releaseResources() override;
    void updateCachedImage();
    bool writeToTexture(QSGPlainTexture *targetTexture) const override;

    QImage cachedSource;
};

#ifndef QT_NO_OPENGL
class DOpenGLBlurEffectNode : public DSGBlurNode
{
public:
    DOpenGLBlurEffectNode(QQuickItem *owner);
    ~DOpenGLBlurEffectNode() override;

    void setTexture(QSGTexture *texture) override;
    void setRadius(qreal radius) override;

    void render(const RenderState *state) override;
    StateFlags changedStates() const override;

private:
    bool writeToTexture(QSGPlainTexture *targetTexture) const override;

    void initialize();
    void initBlurSahder();
    void applyDaulBlur(QOpenGLFramebufferObject* targetFBO, GLuint sourceTexture, QOpenGLShaderProgram *shader
                     , const QSGRenderNode::RenderState *state, int matrixUniform, int scale);
    void applyNoise(GLuint sourceTexture, const QSGRenderNode::RenderState *state);
    void renderToScreen(GLuint sourceTexture, const QSGRenderNode::RenderState *state);
    void initFBOTextures();
    void initDispalyShader();
    void initNoiseShader();

private:
    bool m_needUpdateFBO = false;

    QOpenGLShaderProgram *m_programKawaseUp = nullptr;
    QOpenGLShaderProgram *m_programKawaseDown = nullptr;
    QVector<QOpenGLFramebufferObject*> m_fboVector;
    int m_matrixKawaseUpUniform;
    int m_matrixKawaseDownUniform;
    QOpenGLBuffer *m_sampleVbo = nullptr;

    QOpenGLShaderProgram *m_program = nullptr;
    int m_matrixUniform;
    int m_opacityUniform;
    QOpenGLBuffer *m_vbo = nullptr;

    QOpenGLShaderProgram *m_programNoise = nullptr;
    QOpenGLBuffer *m_noiseVbo = nullptr;
};
#endif

DQUICK_END_NAMESPACE

#endif // DSOFTWAREBLURIMAGENODE_H
