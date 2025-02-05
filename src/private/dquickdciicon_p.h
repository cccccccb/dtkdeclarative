/*
 * Copyright (C) 2021 UnionTech Technology Co., Ltd.
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
#ifndef DQUICKDCIICON_P_H
#define DQUICKDCIICON_P_H

#include <dtkdeclarative_global.h>

#include <DObject>
#include <DDciIconPalette>

#include <QString>
#include <QSharedData>

#include "dquickdciiconimage_p.h"

DQUICK_BEGIN_NAMESPACE
DGUI_USE_NAMESPACE

class DQuickDciIconPrivate;
class DQuickDciIcon
{
    Q_GADGET
    Q_PROPERTY(QString name READ name WRITE setName RESET resetName FINAL)
    Q_PROPERTY(int width READ width WRITE setWidth RESET resetWidth FINAL)
    Q_PROPERTY(int height READ height WRITE setHeight RESET resetHeight FINAL)
    Q_PROPERTY(DTK_QUICK_NAMESPACE::DQMLGlobalObject::ControlState mode READ mode WRITE setMode RESET resetMode FINAL)
    Q_PROPERTY(DTK_GUI_NAMESPACE::DGuiApplicationHelper::ColorType theme READ theme WRITE setTheme RESET resetTheme FINAL)
    Q_PROPERTY(DTK_GUI_NAMESPACE::DDciIconPalette palette READ palette WRITE setPalette RESET resetTheme FINAL)
    // for Qt icon
    Q_PROPERTY(QUrl source READ source WRITE setSource RESET resetSource FINAL)
    Q_PROPERTY(bool fallbackToQIcon READ fallbackToQIcon WRITE setFallbackToQIcon RESET resetFallbackToQIcon)

public:
    DQuickDciIcon();
    DQuickDciIcon(const DQuickDciIcon &other);
    ~DQuickDciIcon();

    DQuickDciIcon& operator=(const DQuickDciIcon &other);
    bool operator==(const DQuickDciIcon &other) const;
    bool operator!=(const DQuickDciIcon &other) const;

    bool isEmpty() const;

    QString name() const;
    void setName(const QString &name);
    void resetName();

    int width() const;
    void setWidth(int width);
    void resetWidth();

    int height() const;
    void setHeight(int height);
    void resetHeight();

    DQMLGlobalObject::ControlState mode() const;
    void setMode(DQMLGlobalObject::ControlState mode);
    void resetMode();

    DGuiApplicationHelper::ColorType theme() const;
    void setTheme(DTK_GUI_NAMESPACE::DGuiApplicationHelper::ColorType theme);
    void resetTheme();

    DDciIconPalette palette() const;
    void setPalette(const DDciIconPalette &palette);
    void resetPalette();

    const QUrl &source() const;
    void setSource(const QUrl &newSource);
    void resetSource();

    bool fallbackToQIcon() const;
    void setFallbackToQIcon(bool newFallbackToQIcon);
    void resetFallbackToQIcon();

private:
    QSharedDataPointer<DQuickDciIconPrivate> d;
};

DQUICK_END_NAMESPACE
#endif // DQUICKDCIICON_P_H
