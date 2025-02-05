﻿/*
 * Copyright (C) 2021 ~ 2022 Uniontech Technology Co., Ltd.
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
import QtQuick.Layouts 1.11
import org.deepin.dtk.settings 1.0
import ".."

RowLayout {
    id: control
    width: parent.width - parent.leftPadding - parent.rightPadding

    property bool leftVisible: true
    Label {
        id: label
        visible: leftVisible
        text: SettingsOption.name
        verticalAlignment: Text.AlignVCenter
    }
    Item {
        visible: leftVisible
        width: 20
    }
}
