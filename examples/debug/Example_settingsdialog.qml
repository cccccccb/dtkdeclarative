/*
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

import QtQuick 2.0
import org.deepin.dtk 1.0
import org.deepin.dtk.settings 1.0 as Settings

Rectangle {
    border.color: "blue"

    property list<Settings.SettingsGroup> __groups: [
        Settings.SettingsGroup {
            key: "group1"
            name: "group1"
            Settings.SettingsOption {
                key: "option1"
                name: "option1"
                Label {
                    text: Settings.SettingsOption.name
                }
            }
        }
    ]

    Settings.SettingsDialog {
        id: settingsDialog
        height: 400
        width: 680
        visible: false
        config: settingsConfig

        //            container.groups: [
        //                Settings.SettingsGroup {
        //                    key: "group1"
        //                    name: "group1"
        //                    visible: true
        //                    Settings.SettingsOption {
        //                        key: "option1"
        //                        name: "option1"
        //                        Label {
        //                            text: Settings.SettingsOption.name
        //                        }
        //                    }
        //                }
        //            ]

        //            container: Settings.SettingsContainer {
        //                id: settingsContainer
        //                config: settingsConfig
        //                navigationTitle: NavigationTitle {}
        //                contentTitle: ContentTitle {}
        //                Settings.ContentBackground: Settings.ContentBackground {}
        //                groups: __groups
        //            }
        container.contentBackground: Settings.ContentBackground {
            border.color: "blue"
        }

        groups: [
            Settings.SettingsGroup {
                key: "group1"
                name: "group1"
                visible: true
                background: Settings.ContentBackground {
                    border.color: "green"
                    radius: 8
                }

                children: [
                    Settings.SettingsGroup {
                        key: "group1"
                        name: "group1"
                        visible: true
                        background: Settings.ContentBackground {
                            border.color: "red"
                            radius: 8
                        }
                        Settings.SettingsOption {
                            key: "key2"
                            name: "ComboBox"
                            Settings.ComboBox {
                                model: ["first", "sceond", "three"]
                            }
                        }
                        Settings.SettingsOption {
                            key: "key3"
                            name: "LineEdit"
                            Settings.LineEdit {}
                        }
                        Settings.SettingsOption {
                            key: "canExit"
                            name: "CheckBox"
                            Settings.CheckBox {}
                        }
                    },
                    Settings.SettingsGroup {
                        key: "group2"
                        name: "group2"
                        children: [
                            Settings.SettingsGroup {
                                key: "group3"
                                name: "group1.group2.group3"
                                visible: true

                                Settings.SettingsOption {
                                    key: "option1"
                                    name: "group2.group1.option1"
                                    Settings.OptionDelegate {
                                        LineEdit {
                                            text: Settings.SettingsOption.name
                                            onEditingFinished: {
                                                Settings.SettingsOption.value = text
                                            }
                                        }
                                    }
                                }
                            }
                        ]
                    }
                ]
            },
            Settings.SettingsGroup {
                key: "group2"
                name: "group2"
                children: [
                    Settings.SettingsGroup {
                        key: "group1"
                        name: "group1"
                        visible: true
                        Settings.SettingsOption {
                            key: "option1"
                            name: "option1"
                            Label {
                                text: Settings.SettingsOption.name
                            }
                        }
                        Settings.SettingsOption {
                            key: "option2"
                            name: "option2"
                            LineEdit {
                                text: Settings.SettingsOption.name
                            }
                        }
                        Settings.SettingsOption {
                            key: "option1"
                            name: "option1"
                            ComboBox {
                                model: ["first", "sceond", "three"]
                            }
                        }
                    }
                ]
            },
            Settings.SettingsGroup {
                key: "group3"
                name: "group3"
            },
            Settings.SettingsGroup {
                key: "group4"
                name: "group4"
            }
        ]
    }

    Column {
        width: parent.width
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        Button {
            text: "showSettingsDialog"
            onClicked: {
                settingsDialog.show()
            }
        }

        Row {
            ComboBox {
                id: groups
                model: ["group1", "group1.group1", "group2.group1"]
            }
            Button {
                property string groupKey: groups.currentText
                text: groupKey
                onClicked: {
                    settingsDialog.container.setGroupVisible(groupKey, !settingsDialog.container.groupVisible(groupKey))
                }
            }
        }
    }

    // Config should be loaded first
    Config {
        id: settingsConfig
        name: "example"
        subpath: ""
        property string key3 : "key3 default"
    }
}
