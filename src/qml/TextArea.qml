/*
 * Copyright (C) 2020 ~ 2022 UnionTech Technology Co., Ltd.
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
import QtQuick.Controls.impl 2.4
import QtQuick.Templates 2.4 as T
import org.deepin.dtk.impl 1.0 as D
import org.deepin.dtk.style 1.0 as DS

T.TextArea {
    id: control

    property D.Palette placeholderTextColor: DS.Style.edit.placeholderText
    implicitWidth: Math.max(DS.Style.control.implicitWidth(control), placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(DS.Style.control.implicitHeight(control), placeholder.implicitHeight + topPadding + bottomPadding)

    padding: DS.Style.control.padding

    color: palette.text
    selectionColor: palette.highlight
    selectedTextColor: palette.highlightedText
    onEffectiveHorizontalAlignmentChanged: placeholder.effectiveHorizontalAlignmentChanged()

    Loader {
        id: placeholder
        active: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)
        signal effectiveHorizontalAlignmentChanged

        sourceComponent: PlaceholderText {
            text: control.placeholderText
            font: control.font
            color: control.D.ColorSelector.placeholderTextColor
            verticalAlignment: control.verticalAlignment
            elide: Text.ElideRight
            renderType: control.renderType
        }
    }

    background: EditPanel {
        control: control
        implicitWidth: DS.Style.edit.width
        implicitHeight: DS.Style.edit.textAreaHeight
    }
}
