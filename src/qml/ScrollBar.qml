/*
 * Copyright (C) 2022 UnionTech Technology Co., Ltd.
 *
 * Author:     yeshanshan <yeshanshan@uniontech.com>
 *
 * Maintainer: yeshanshan <yeshanshan@uniontech.com>
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
import QtQuick.Templates 2.4 as T
import org.deepin.dtk.impl 1.0 as D
import org.deepin.dtk.style 1.0 as DS

T.ScrollBar {
    id: control

    implicitWidth: DS.Style.control.implicitWidth(control)
    implicitHeight: DS.Style.control.implicitHeight(control)

    padding: DS.Style.scrollBar.padding
    visible: control.policy !== T.ScrollBar.AlwaysOff

    state: "hide"
    states: [
        State {
            name: "hide"
            when: control.policy === T.ScrollBar.AlwaysOff || !control.active || control.size >= 1.0
            PropertyChanges {
                target: control.contentItem
                implicitWidth: DS.Style.scrollBar.width
                opacity: DS.Style.scrollBar.hideOpacity
            }
        },
        State {
            name: "normal"
            property bool moving: control.active && !control.pressed && !control.hovered
            when: control.policy === T.ScrollBar.AlwaysOn || ( moving && control.size < 1.0)
            PropertyChanges {
                target: control.contentItem
                implicitWidth: DS.Style.scrollBar.width
            }
        },
        State {
            name: "hover"
            when: control.policy === T.ScrollBar.AlwaysOn || ( control.hovered && !control.pressed && control.size < 1.0)
            PropertyChanges {
                target: control.contentItem
                implicitWidth: DS.Style.scrollBar.activeWidth
            }
        },
        State {
            name: "active"
            when: control.policy === T.ScrollBar.AlwaysOn || (control.pressed && control.size < 1.0)
            PropertyChanges {
                target: control.contentItem
                implicitWidth: DS.Style.scrollBar.activeWidth
            }
        }
    ]

    transitions: Transition {
        to: "hide"
        SequentialAnimation {
            PauseAnimation { duration: DS.Style.scrollBar.hidePauseDuration }
            NumberAnimation { target: control.contentItem; duration: DS.Style.scrollBar.hideDuration; property: "opacity"; to:DS.Style.scrollBar.hideOpacity }
        }
    }

    contentItem: Item {
        id: content
        property D.Palette backgroundColor: DS.Style.scrollBar.background
        property D.Palette insideBorderColor: DS.Style.scrollBar.insideBorder
        property D.Palette outsideBorderColor: DS.Style.scrollBar.outsideBorder

        implicitWidth: DS.Style.scrollBar.width
        implicitHeight: implicitWidth

        Rectangle {
            id: backgroundRect
            anchors.fill: parent
            radius: control.orientation == Qt.Horizontal ? control.height / 2 : control.width / 2
            color: content.D.ColorSelector.backgroundColor
        }

        InsideBoxBorder {
            anchors.fill: backgroundRect
            radius: backgroundRect.radius
            color: content.D.ColorSelector.insideBorderColor
            borderWidth: DS.Style.control.borderWidth
        }

        OutsideBoxBorder {
            anchors.fill: backgroundRect
            radius: backgroundRect.radius
            color: content.D.ColorSelector.outsideBorderColor
            borderWidth: DS.Style.control.borderWidth
        }
    }
}
