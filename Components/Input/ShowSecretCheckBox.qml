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

CheckBox {
    id: revealSecret
    width: {
        indicator.implicitWidth +
        indicator.anchors.leftMargin +
        contentItem.anchors.leftMargin +
        contentItem.implicitWidth
    }
    hoverEnabled: true

    indicator: Rectangle {
        id: indicator
        anchors {
            left: parent.left
            top: parent.top
            topMargin: 3
            leftMargin: 4
        }
        implicitHeight: root.font.pointSize
        implicitWidth: root.font.pointSize
        color: "transparent"
        border {
            color: root.palette.text
            width: parent.activeFocus ? 2 : 1
        }

        Rectangle {
            id: dot
            anchors.centerIn: parent
            implicitHeight: parent.width - 6
            implicitWidth: parent.width - 6
            color: root.palette.text
            opacity: revealSecret.checked ? 1 : 0
        }
    }

    contentItem: Text {
        id: indicatorLabel
        text: config.TranslateShowPassword || "Show Password"
        anchors {
            verticalCenter: indicator.verticalCenter
            left: indicator.right
            leftMargin: indicator.width / 2
        }
        horizontalAlignment: Text.AlignLeft
        font.pointSize: root.font.pointSize * 0.8
        color: root.palette.text
    }

    background: Rectangle {
        color: "transparent"
        border {
            width: parent.activeFocus ? 1 : 0
            color: parent.activeFocus ? root.palette.text : "transparent"
        }
        height: parent.activeFocus ? 2 : 0
        width: (indicator.width + indicatorLabel.contentWidth + indicatorLabel.anchors.leftMargin + 2)
        anchors {
            top: indicatorLabel.bottom
            left: parent.left
            leftMargin: 3
            topMargin: 8
        }
    }

    states: [
        State {
            name: "pressed"
            when: revealSecret.down
            PropertyChanges {
                target: revealSecret.contentItem
                color: Qt.darker(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: dot
                color: Qt.darker(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: indicator
                border.color: Qt.darker(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: revealSecret.background
                border.color: Qt.darker(root.palette.highlight, 1.1)
            }
        },
        State {
            name: "hovered"
            when: revealSecret.hovered
            PropertyChanges {
                target: indicatorLabel
                color: Qt.lighter(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: indicator
                border.color: Qt.lighter(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: dot
                color: Qt.lighter(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: revealSecret.background
                border.color: Qt.lighter(root.palette.highlight, 1.1)
            }
        },
        State {
            name: "focused"
            when: revealSecret.activeFocus
            PropertyChanges {
                target: indicatorLabel
                color: root.palette.highlight
            }
            PropertyChanges {
                target: indicator
                border.color: root.palette.highlight
            }
            PropertyChanges {
                target: dot
                color: root.palette.highlight
            }
            PropertyChanges {
                target: revealSecret.background
                border.color: root.palette.highlight
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                properties: "color, border.color, opacity"
                duration: 150
            }
        }
    ]
}
