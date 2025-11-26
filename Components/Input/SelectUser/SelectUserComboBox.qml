//
// This file is part of SDDM Anime Tactical.
// A theme for the Simple Display Desktop Manager.
//
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

import "../"

ComboBox {
    id: selectUser
    model: userModel
    currentIndex: model.lastIndex
    textRole: "name"
    hoverEnabled: true

    width: height
    height: parent.height
    anchors {
        verticalCenter: parent.verticalCenter
        left: parent.left
    }

    contentItem: Item {}

    delegate: PopupDelegateBase {
        highlighted: selectUser.highlightedIndex === index
    }

    indicator: SelectUserButton {
        id: usernameIcon
    }

    popup: SelectUserPopup {}

    background: Rectangle {
        color: "transparent"
        border.width: 0
    }

    states: [
        State {
            name: "pressed"
            when: selectUser.down
            PropertyChanges {
                target: usernameIcon
                icon.color: Qt.lighter(root.palette.highlight, 1.1)
            }
        },
        State {
            name: "hovered"
            when: selectUser.hovered
            PropertyChanges {
                target: usernameIcon
                icon.color: Qt.lighter(root.palette.highlight, 1.2)
            }
        },
        State {
            name: "focused"
            when: selectUser.activeFocus
            PropertyChanges {
                target: usernameIcon
                icon.color: root.palette.highlight
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                properties: "color, border.color, icon.color"
                duration: 150
            }
        }
    ]
}
