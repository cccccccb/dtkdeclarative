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
import org.deepin.dtk.settings 1.0
import org.deepin.dtk.style 1.0 as DS

Rectangle {
    anchors {
        left: parent.left
        leftMargin: __getMargin(SettingsGroup.level)
        right: parent.right
        rightMargin: __getMargin(SettingsGroup.level)
    }
    height: childrenRect.height
    radius: DS.Style.control.radius

    function __getMargin(level) {
        switch(level) {
        case 0:
            return DS.Style.settings.content.marginL1
        case 1:
            return DS.Style.settings.content.marginL2
        }
        return DS.Style.settings.content.marginOther
    }
}
