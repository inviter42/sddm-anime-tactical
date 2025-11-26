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
import QtQuick.Controls

Item {
    id: sessionButton

    property string textConstantSession
    property int loginButtonWidth

    readonly property int selectedSession: selectSession.currentIndex

    property alias exposeSession: selectSession

    width: parent.width
    height: selectSession.height
    anchors.horizontalCenter: parent.horizontalCenter

    ComboBox {
        id: selectSession
        hoverEnabled: true
        model: sessionModel
        currentIndex: model.lastIndex
        textRole: "name"
        implicitWidth: parent.width

        background: Rectangle {
            width: displayedItem.implicitWidth
            height: parent.activeFocus ? 2 : 0
            color: "transparent"
            border {
                width: parent.activeFocus ? 1 : 0
                color: "transparent"
            }
            anchors {
                top: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        contentItem: Text {
            id: displayedItem
            text: (config.TranslateSession || (textConstantSession + ":")) + " " + selectSession.currentText
            color: root.palette.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: root.font.pointSize * 0.8
            Keys.onReleased: parent.popup.open()
        }

        indicator { visible: false }

        popup: PopupBase {
            id: popupHandler
            implicitWidth: sessionButton.width
            implicitHeight: Math.min(contentItem.implicitHeight, root.height / 5)

            listView {
                model: selectSession.popup.visible ? selectSession.delegateModel : null
                currentIndex: selectSession.highlightedIndex
            }
        }

        delegate: PopupDelegateBase {
            highlighted: selectSession.highlightedIndex === index
        }

        states: [
            State {
                name: "pressed"
                when: selectSession.down
                PropertyChanges {
                    target: displayedItem
                    color: Qt.darker(root.palette.highlight, 1.1)
                }
                PropertyChanges {
                    target: selectSession.background
                    border.color: Qt.darker(root.palette.highlight, 1.1)
                }
            },
            State {
                name: "hovered"
                when: selectSession.hovered
                PropertyChanges {
                    target: displayedItem
                    color: Qt.lighter(root.palette.highlight, 1.1)
                }
                PropertyChanges {
                    target: selectSession.background
                    border.color: Qt.lighter(root.palette.highlight, 1.1)
                }
            },
            State {
                name: "focused"
                when: selectSession.activeFocus
                PropertyChanges {
                    target: displayedItem
                    color: root.palette.highlight
                }
                PropertyChanges {
                    target: selectSession.background
                    border.color: root.palette.highlight
                }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "color, border.color"
                    duration: 150
                }
            }
        ]
    }
}
