/*
 * Copyright (C) 2020 ~ 2022 Deepin Technology Co., Ltd.
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
import QtQuick.Layouts 1.11
import org.deepin.dtk.impl 1.0 as D
import org.deepin.dtk.style 1.0 as DS

LineEdit {
    id: control
    property alias placeholder: centerIndicatorLabel.text
    default property bool editting: control.activeFocus || (text.length !== 0)
    leftPadding: (editting) ? searchIcon.width + DS.Style.searchEdit.iconLeftMargin
                              + DS.Style.searchEdit.iconRightMargin
                            : 0

    // The search background will be hidden in the focus state,
    // no text input and displayed in the non focus state.
    Item {
        id: searchBackground
        anchors.fill: parent

        RowLayout {
            id: centerIndicator
            spacing: DS.Style.control.spacing

            // Search Icon
            D.DciIcon {
                id: searchIcon
                name: "action_search"
                sourceSize.width: DS.Style.searchEdit.iconSize
                palette: D.DTK.makeIconPalette(control.palette)
                mode: control.D.ColorSelector.controlState
                theme: control.D.ColorSelector.controlTheme
                fallbackToQIcon: false
            }

            Text {
                id: centerIndicatorLabel
                text: qsTr("Search")
                color: palette.text
                verticalAlignment: Text.AlignVCenter
            }
        }

        MouseArea {
            anchors.fill: parent
            visible: !editting
            onClicked: {
                control.forceActiveFocus(Qt.MouseFocusReason)
                mouse.accepted = false
            }
        }

        state: "NONEDIT"
        states: [
            State {
                name: "EDITTING"
                when: editting
                AnchorChanges {
                    target: centerIndicator
                    anchors.left: searchBackground.left
                    anchors.verticalCenter: searchBackground.verticalCenter
                }
                PropertyChanges {
                    target: centerIndicator
                    anchors.leftMargin: DS.Style.searchEdit.iconLeftMargin
                }
                PropertyChanges {
                    target: centerIndicatorLabel
                    color: "transparent"
                }
            },
            State {
                name: "NONEDIT"
                when: !editting
                AnchorChanges {
                    target: centerIndicator
                    anchors.horizontalCenter: searchBackground.horizontalCenter
                    anchors.verticalCenter: searchBackground.verticalCenter
                }
                PropertyChanges {
                    target: centerIndicatorLabel
                    color: palette.text
                }
            }
        ]

        transitions: Transition {
            AnchorAnimation {
                duration: DS.Style.searchEdit.animationDuration
                easing.type: Easing.OutCubic
            }
            ColorAnimation {
                duration: DS.Style.searchEdit.animationDuration
                easing.type: Easing.OutCubic
            }
        }
    }
}
