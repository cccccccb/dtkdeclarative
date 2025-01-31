﻿/*
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

#ifndef DQUICKBEHINDWINDOWBLUR_P_P_H
#define DQUICKBEHINDWINDOWBLUR_P_P_H

#include "dquickbehindwindowblur_p.h"
#include "dquickwindow.h"

#include <private/qquickitem_p.h>

DQUICK_BEGIN_NAMESPACE

class DQuickBehindWindowBlurPrivate : public QQuickItemPrivate
{
    Q_DECLARE_PUBLIC(DQuickBehindWindowBlur)

public:
    DQuickBehindWindowBlurPrivate()
        : windowAttach(nullptr)
        , blendColor(Qt::transparent)
    {

    }
    ~DQuickBehindWindowBlurPrivate();

    void _q_updateBlurArea();
    inline bool isValidBlur() const {
        if (!blurPath.isEmpty())
            return true;
        return blurArea.width > 0 && blurArea.height > 0;
    }
    inline void makeToInvalidBlur() {
#if QT_VERSION >= QT_VERSION_CHECK(5, 15, 0)
        blurPath.clear();
#else
        blurPath = QPainterPath();
#endif
        blurArea.width = blurArea.height = -1;
    }

    DQuickWindowAttached *windowAttach = nullptr;

    qreal radius;
    QColor blendColor;
    DPlatformHandle::WMBlurArea blurArea;
    QPainterPath blurPath;
};

DQUICK_END_NAMESPACE

#endif // DQUICKBEHINDWINDOWBLUR_H_H
