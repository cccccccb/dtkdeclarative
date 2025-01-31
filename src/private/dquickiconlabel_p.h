/*
 * Copyright (C) 2020 ~ 2022 Uniontech Technology Co., Ltd.
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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DQUICKICONLABEL_P_H
#define DQUICKICONLABEL_P_H

#include "dquickdciicon_p.h"

#include <dtkdeclarative_global.h>

#include <QQuickItem>

DQUICK_BEGIN_NAMESPACE

class DQuickIconLabelPrivate;

class DQuickIconLabel : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(DTK_QUICK_NAMESPACE::DQuickDciIcon icon READ icon WRITE setIcon FINAL)
    Q_PROPERTY(QString text READ text WRITE setText FINAL)
    Q_PROPERTY(QFont font READ font WRITE setFont FINAL)
    Q_PROPERTY(QColor color READ color WRITE setColor FINAL)
    Q_PROPERTY(Display display READ display WRITE setDisplay FINAL)
    Q_PROPERTY(qreal spacing READ spacing WRITE setSpacing FINAL)
    Q_PROPERTY(bool mirrored READ isMirrored WRITE setMirrored FINAL)
    Q_PROPERTY(Qt::Alignment alignment READ alignment WRITE setAlignment FINAL)
    Q_PROPERTY(qreal topPadding READ topPadding WRITE setTopPadding RESET resetTopPadding FINAL)
    Q_PROPERTY(qreal leftPadding READ leftPadding WRITE setLeftPadding RESET resetLeftPadding FINAL)
    Q_PROPERTY(qreal rightPadding READ rightPadding WRITE setRightPadding RESET resetRightPadding FINAL)
    Q_PROPERTY(qreal bottomPadding READ bottomPadding WRITE setBottomPadding RESET resetBottomPadding FINAL)

public:
    enum Display {
        IconOnly,
        TextOnly,
        TextBesideIcon,
        TextUnderIcon,
        IconBesideText = 128 // Extended value, previous values are consistent with AbstractButton.
    };
    Q_ENUM(Display)

    explicit DQuickIconLabel(QQuickItem *parent = nullptr);
    ~DQuickIconLabel() override;

    DQuickDciIcon icon() const;
    void setIcon(const DQuickDciIcon &dciIcon);

    QString text() const;
    void setText(const QString &text);

    QFont font() const;
    void setFont(const QFont &font);

    QColor color() const;
    void setColor(const QColor &color);

    Display display() const;
    void setDisplay(Display display);

    qreal spacing() const;
    void setSpacing(qreal spacing);

    bool isMirrored() const;
    void setMirrored(bool mirrored);

    Qt::Alignment alignment() const;
    void setAlignment(Qt::Alignment alignment);

    qreal topPadding() const;
    void setTopPadding(qreal padding);
    void resetTopPadding();

    qreal leftPadding() const;
    void setLeftPadding(qreal padding);
    void resetLeftPadding();

    qreal rightPadding() const;
    void setRightPadding(qreal padding);
    void resetRightPadding();

    qreal bottomPadding() const;
    void setBottomPadding(qreal padding);
    void resetBottomPadding();

protected:
    void componentComplete() override;
    void geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry) override;

private:
    Q_DISABLE_COPY(DQuickIconLabel)
    Q_DECLARE_PRIVATE(DQuickIconLabel)
};

DQUICK_END_NAMESPACE

#endif // DQUICKICONLABEL_P_H
