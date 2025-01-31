/*
 * Copyright (C) 2022 UnionTech Technology Co., Ltd.
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

import QtQuick 2.0
import org.deepin.dtk.impl 1.0 as D

Item {
    id: root

    property real cornerRadius: 0
    property real shadowBlur: 10
    property real shadowOffsetX: 0
    property real shadowOffsetY: 0
    property color shadowColor: "black"
    property real spread: 0
    property bool hollow: false
    readonly property real __offsetX: hollow ? shadowOffsetX : 0
    readonly property real __offsetY: hollow ? shadowOffsetY : 0
    readonly property real __spread: hollow ? spread : 0
    readonly property real __borderBase: cornerRadius + spread + shadowBlur * 2
    readonly property real __minImageSize: 2 * __borderBase
    readonly property real __boxSize: __minImageSize - 2 * shadowBlur - 2 * __spread + 1

    BorderImage {
        id: image

        anchors {
            centerIn: parent
            horizontalCenterOffset:  shadowOffsetX
            verticalCenterOffset: shadowOffsetY
        }
        width: parent.width + (shadowBlur + spread) * 2
        height: parent.height + (shadowBlur + spread) * 2

        source: D.DTK.makeShadowImageUrl(__boxSize, cornerRadius, shadowBlur, shadowColor, __offsetX, __offsetY, __spread, hollow, false)

        function bound(min, val, max) {
            if (val <= min)
                return min;
            if (val >= max)
                return max;
            return val;
        }

        border {
            left: Math.min(width / 2, __borderBase - __offsetX)
            right: Math.min(width / 2, __borderBase + __offsetX)
            top: Math.min(height / 2, __borderBase - __offsetY)
            bottom: Math.min(height / 2, __borderBase + __offsetY)
        }
    }
}
