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
import org.deepin.dtk.impl 1.0 as D
import org.deepin.dtk.style 1.0 as DS

BoxPanel {
    id: control
    property Item button

    color1: selectValue(DS.Style.button.background1, DS.Style.checkedButton.background, DS.Style.highlightedButton.background1)
    color2: selectValue(DS.Style.button.background2, DS.Style.checkedButton.background, DS.Style.highlightedButton.background2)
    insideBorderColor: selectValue(DS.Style.button.insideBorder, null, DS.Style.highlightedButton.border)
    outsideBorderColor: selectValue(DS.Style.button.outsideBorder, null, null)
    dropShadowColor: selectValue(DS.Style.button.dropShadow, DS.Style.checkedButton.dropShadow, DS.Style.highlightedButton.dropShadow)
    innerShadowColor1: selectValue(DS.Style.button.innerShadow1, DS.Style.checkedButton.innerShadow, DS.Style.highlightedButton.innerShadow1)
    innerShadowColor2: selectValue(DS.Style.button.innerShadow2, null, DS.Style.highlightedButton.innerShadow2)
    boxShadowBlur: selectValue(control.D.ColorSelector.controlState === D.DTK.PressedState ? 4 : 6, 6, 4)
    boxShadowOffsetY: selectValue(control.D.ColorSelector.controlState === D.DTK.PressedState ? 2 : 4, 4, 4)
    innerShadowOffsetY1: selectValue(control.D.ColorSelector.controlState === D.DTK.HoveredState ? -3 : -1, -1, -1)
    visible: !button.flat || button.checked || button.highlighted || button.visualFocus || control.D.ColorSelector.controlState === D.DTK.PressedState || control.D.ColorSelector.controlState === D.DTK.HoveredState

    function selectValue(normal, checked, highlighted) {
        if (button.checked) {
            return checked
        } else if ((typeof button.highlighted == "boolean") && button.highlighted) {
            return highlighted
        }

        return normal
    }

    Loader {
        anchors.fill: parent
        active: button.visualFocus

        sourceComponent: FocusBoxBorder {
            radius: control.radius
            color: button.palette.highlight
        }
    }

    Gradient {
        id: hoverBackgroundGradient
        GradientStop { position: 0.0; color: control.D.ColorSelector.color1 }
        GradientStop { position: 0.96; color: control.D.ColorSelector.color2 }
    }

    CicleSpreadAnimation {
        id: hoverAnimation
        anchors.fill: parent
        visible: control.D.ColorSelector.controlState === D.DTK.HoveredState
                 && control.D.ColorSelector.family === D.Palette.CommonColor

        Rectangle {
            anchors.fill: parent
            radius: control.radius
            gradient: control.D.ColorSelector.color1 === control.D.ColorSelector.color2 ? null : hoverBackgroundGradient
            color: control.D.ColorSelector.color1
        }

        Component.onCompleted: {
            button.hoveredChanged.connect(function () {
                if (button.hovered) {
                    var pos = D.DTK.cursorPosition()
                    hoverAnimation.centerPoint = hoverAnimation.mapFromGlobal(pos.x, pos.y)
                    hoverAnimation.start()
                } else {
                    hoverAnimation.stop()
                }
            })
        }
    }
}
