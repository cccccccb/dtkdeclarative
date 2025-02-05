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

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Templates 2.4 as T
import org.deepin.dtk.impl 1.0 as D
import org.deepin.dtk.style 1.0 as DS

T.ProgressBar {
    id: control

    property D.Palette backgroundColor: DS.Style.embeddedProgressBar.background
    property D.Palette progressBackgroundColor: DS.Style.embeddedProgressBar.progressBackground

    implicitWidth: DS.Style.control.implicitWidth(control)
    implicitHeight: DS.Style.control.implicitHeight(control)
    padding: 1

    background: Rectangle {
        implicitWidth: DS.Style.embeddedProgressBar.width
        implicitHeight: DS.Style.embeddedProgressBar.height
        radius: DS.Style.embeddedProgressBar.backgroundRadius
        color: control.D.ColorSelector.backgroundColor
    }

    contentItem: Item {
        Item {
            width: control.visualPosition * control.width
            height: DS.Style.embeddedProgressBar.contentHeight
            clip: true

            Rectangle {
                color: control.D.ColorSelector.progressBackgroundColor
                radius: DS.Style.embeddedProgressBar.contentRadius
                width: background.width
                height: parent.height
            }
        }
    }
}
