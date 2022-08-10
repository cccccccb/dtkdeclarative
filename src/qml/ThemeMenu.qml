﻿/*
 * Copyright (C) 2021 ~ 2022 UnionTech Technology Co., Ltd.
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
import org.deepin.dtk.impl 1.0 as D

Menu {
    id: control

    title: qsTr("Theme")
    ActionGroup {
        id: themeEG
        exclusive: true
        onTriggered: {
            D.ApplicationHelper.setPaletteType(action.themeType)
        }
    }

    Action {
        text: qsTr("Light Theme")
        readonly property int themeType: D.ApplicationHelper.LightType
        checked: D.DTK.themeType === themeType
        ActionGroup.group: themeEG
    }
    Action {
        text: qsTr("Dark Theme")
        readonly property int themeType: D.ApplicationHelper.DarkType
        checked: D.DTK.themeType === themeType
        ActionGroup.group: themeEG
    }
    Action {
        text: qsTr("System Theme")
        readonly property int themeType: D.ApplicationHelper.UnknownType
        ActionGroup.group: themeEG
    }
}
