/*
 * Copyright (C) 2021 ~ 2022 UnionTech Software Technology Co., Ltd.
 *
 * Author:     wangfei <wangfeia@uniontech.com>
 *
 * Maintainer: wangfei <wangfeia@uniontech.com>
 *             yeshanshan <yeshanshan@uniontech.com>
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

import QtQuick 2.11
import org.deepin.dtk.impl 1.0 as D
import org.deepin.dtk.style 1.0 as DS

Button {
    id: control

    implicitWidth: Math.max(DS.Style.control.implicitWidth(control), DS.Style.control.implicitHeight(control))
    implicitHeight: implicitWidth

    topPadding: DS.Style.iconButton.padding
    bottomPadding: DS.Style.iconButton.padding
    leftPadding: DS.Style.iconButton.padding
    rightPadding: DS.Style.iconButton.padding
    icon {
        width: DS.Style.iconButton.iconSize
        height: DS.Style.iconButton.iconSize
        color: D.ColorSelector.textColor
    }

    contentItem: D.DciIcon {
        name: control.icon.name
        palette: D.DTK.makeIconPalette(control.palette)
        mode: control.D.ColorSelector.controlState
        theme: control.D.ColorSelector.controlTheme
        sourceSize: Qt.size(control.icon.width, control.icon.height)
    }

    background: ButtonPanel {
        implicitWidth: DS.Style.iconButton.backgroundSize
        implicitHeight: DS.Style.iconButton.backgroundSize
        button: control
    }
}
