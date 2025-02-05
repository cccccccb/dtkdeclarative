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

import QtQuick 2.0
import QtQuick.Layouts 1.11
import org.deepin.dtk 1.0

Column {
    id: control

    Row{
        Button {
            text: "Normal"
            onClicked: normalMenu.popup(control,  Qt.point(x, height))
        }
        Button {
            text: "Action checkd"
            onClicked: {
                var action = normalMenu.actionAt(4)
                action.checked = !action.checked
            }
        }
        Button {
            text: "MenuItem checkd"
            onClicked: {
                var item = normalMenu.itemAt(1)
                item.checked = !item.checked
            }
        }
        Button {
            text: "MenuItem Add"
            onClicked: {
                normalMenu.addItem(menuItem.createObject(normalMenu))
            }

            Component {
                id: menuItem
                MenuItem {
                    text: "Long long text                 menu"
                }
            }
        }
    }
    Row {
        SearchEdit {
            id: filterSearchEdit
            placeholder: qsTr("搜索")
            onTextChanged: {
                objectModelFilter.update()
            }
        }
        Button {
            text: "open menu"
            onClicked: searchAndArrowMenu.popup()
        }
    }

    Menu {
        id: normalMenu
//            width: 300
        header: SearchEdit {
            placeholder: qsTr("搜索")
        }
        maxVisibleItems: 4
        MenuItem {
            icon.name: "music"
            text: "icon"
            onTriggered: console.log("trigger", text)
        }
        MenuItem {
            icon.name: "music"
            text: "Checked"
            checked: true
        }

        MenuSeparator { text: "文本" }

        MenuItem {
            icon.name: "music"
            text: "icon right"
            display: IconLabel.IconBesideText
        }
        Action { text: "Action" ; /*checkable: true;*/ /*checked: true*/}

        MenuSeparator { }

        Menu {
            title: "ShortText menu"
            Action { text: "Find Next" /*; checked: true*/}
            Action { text: "Find Previous" }
            Action { text: "Replace" }
            Menu {
                title: "three"
                Action { text: "Find Next" }
                Action { text: "Find Previous" }
                Action { text: "Replace" }
            }
        }
        Menu {
            title: "LongText                 menu"
            Action { text: "Find Next" }
            Action { text: "Find Previous" }
            Action { text: "Replace" }
        }
    }

    Menu {
        id: searchAndArrowMenu
        closePolicy: Popup.NoAutoClose
        model: ObjectModelProxy {
            id: objectModelFilter
            filterAcceptsItem: function(item) {
                return item.text.includes(filterSearchEdit.text)
            }
            sourceModel: searchAndArrowMenu.contentModel
        }
        MenuItem { text: qsTr("Greek(cp869)") }
        MenuItem { text: qsTr("Cyrillic (ISO 8859-5)") }
        MenuItem { text: qsTr("Cyrillic(KOI8-R)") }
        MenuItem { text: qsTr("Devanagari(x-mac-davanagari)") }
        MenuItem { text: qsTr("Gurmukhi(x-mac-gurmukhi)") }
        MenuItem { text: qsTr("Thai (ISO 8859-11)") }
    }
}
