//
// This file is part of SDDM Anime Tactical.
// A theme for the Simple Display Desktop Manager.
//
// Copyright (C) 2018–2020 Marian Arlt
// Copyright (C) 2025 Ivan Alantiev
//
// SDDM Anime Tactical is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the
// Free Software Foundation, either version 3 of the License, or any later version.
//
// You are required to preserve this and any additional legal notices, either
// contained in this file or in other files that you received along with
// SDDM Anime Tactical that refer to the author(s) in accordance with
// sections §4, §5 and specifically §7b of the GNU General Public License.
//
// SDDM Anime Tactical is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with SDDM Anime Tactical. If not, see <https://www.gnu.org/licenses/>
//

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {

    property ComboBox exposedSession

    readonly property var suspend: {
        "resource": "Suspend",
        "text": config.TranslateSuspend || textConstants.suspend,
        "visibility": sddm.canSuspend,
        "action": sddm.suspend
    }

    readonly property var hibernate: {
        "resource": "Hibernate",
        "text": config.TranslateHibernate || textConstants.hibernate,
        "visibility": sddm.canHibernate,
        "action": sddm.hibernate
    }

    readonly property var reboot: {
        "resource": "Reboot",
        "text": config.TranslateReboot || textConstants.reboot,
        "visibility": sddm.canReboot,
        "action": sddm.reboot
    }

    readonly property var shutdown: {
        "resource": "Shutdown",
        "text": config.TranslateShutdown || textConstants.shutdown,
        "visibility": sddm.canPowerOff,
        "action": sddm.powerOff
    }

    spacing: root.font.pointSize

    Repeater {
        id: systemButtons
        model: [suspend, hibernate, reboot, shutdown]

        RoundButton {
            text: modelData.text
            font.pointSize: root.font.pointSize * 0.8
            Layout.alignment: Qt.AlignHCenter
            icon {
                source: modelData ? Qt.resolvedUrl(`${root.assetsURL}/${modelData.resource}.svgz`) : ""
                height: 2 * Math.round((root.font.pointSize * 3) / 2)
                width: 2 * Math.round((root.font.pointSize * 3) / 2)
                color: root.palette.text
            }
            display: AbstractButton.TextUnderIcon
            visible: config.ForceHideSystemButtons !== "true" && modelData.visibility
            hoverEnabled: true
            palette.buttonText: root.palette.text
            background: Rectangle {
                height: 2
                color: "transparent"
                width: parent.width
                border {
                    width: parent.activeFocus ? 1 : 0
                    color: "transparent"
                }
                anchors.top: parent.bottom
            }

            focus: true

            onClicked: {
                parent.forceActiveFocus()
                modelData.action()
            }

            Keys.onEnterPressed: {
                clicked()
            }

            Keys.onReturnPressed: {
                clicked()
            }

            Keys.onEscapePressed: {
                if (inputs.state === "visible") {
                    root.toggleState()
                }

                systemButtonsFocusScope.focus = false
            }

            KeyNavigation.up: exposedSession
            KeyNavigation.left: parent.children[index-1] ?? null

            states: [
                State {
                    name: "pressed"
                    when: parent.children[index].down
                    PropertyChanges {
                        target: parent.children[index]
                        palette.buttonText: Qt.darker(root.palette.highlight, 1.1)
                        icon.color: Qt.darker(root.palette.highlight, 1.1)
                    }
                    PropertyChanges {
                        target: parent.children[index].background
                        border.color: Qt.darker(root.palette.highlight, 1.1)
                    }
                },
                State {
                    name: "hovered"
                    when: parent.children[index].hovered
                    PropertyChanges {
                        target: parent.children[index]
                        palette.buttonText: Qt.lighter(root.palette.highlight, 1.1)
                        icon.color: Qt.lighter(root.palette.highlight, 1.1)
                    }
                    PropertyChanges {
                        target: parent.children[index].background
                        border.color: Qt.lighter(root.palette.highlight, 1.1)
                    }
                },
                State {
                    name: "focused"
                    when: parent.children[index].activeFocus
                    PropertyChanges {
                        target: parent.children[index]
                        palette.buttonText: root.palette.highlight
                        icon.color: root.palette.highlight
                    }
                    PropertyChanges {
                        target: parent.children[index].background
                        border.color: root.palette.highlight
                    }
                }
            ]

            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "palette.buttonText, border.color, icon.color"
                        duration: 150
                    }
                }
            ]
        }
    }
}
