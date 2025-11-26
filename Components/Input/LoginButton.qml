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

Button {
    id: loginButton
    enabled: config.AllowEmptyPassword === "true" || username.text !== "" && password.text !== ""
    anchors.horizontalCenter: parent.horizontalCenter
    text: config.TranslateLogin || textConstants.login
    height: root.font.pointSize * 3
    implicitWidth: parent.width
    hoverEnabled: true

    contentItem: Text {
        text: parent.text
        color: {
            loginButton.enabled
                ? config.OverrideLoginButtonTextColor === ""
                    ? root.palette.buttonText
                    : config.OverrideLoginButtonTextColor
                : "white"
        }
        font.pointSize: root.font.pointSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        opacity: 0.5
    }

    background: Rectangle {
        id: buttonBackground
        color: Qt.rgba(1,1,1,0.2)
        radius: config.RoundCorners || 0
    }

    states: [
        State {
            name: "pressed"
            when: loginButton.down

            PropertyChanges {
                target: buttonBackground
                color: Qt.darker(root.palette.highlight, 1.1)
                opacity: 1
            }
            PropertyChanges {
                target: loginButton.contentItem
            }
        },
        State {
            name: "hovered"
            when: loginButton.hovered

            PropertyChanges {
                target: buttonBackground
                color: loginButton.enabled ? Qt.lighter(root.palette.highlight, 1.15) : Qt.rgba(1,1,1,0.2)
                opacity: 1
            }
            PropertyChanges {
                target: loginButton.contentItem
                opacity: loginButton.enabled ? 1 : 0.5
            }
        },
        State {
            name: "focused"
            when: loginButton.activeFocus

            PropertyChanges {
                target: buttonBackground
                color: Qt.lighter(root.palette.highlight, 1.2)
                opacity: 1
            }
            PropertyChanges {
                target: loginButton.contentItem
                opacity: 1
            }
        },
        State {
            name: "enabled"
            when: loginButton.enabled

            PropertyChanges {
                target: buttonBackground;
                color: root.palette.highlight;
                opacity: 1
            }
            PropertyChanges {
                target: loginButton.contentItem;
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                properties: "opacity, color";
                duration: 300
            }
        }
    ]
}
