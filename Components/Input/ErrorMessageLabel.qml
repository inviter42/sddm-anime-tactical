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

Label {
    id: errorMessage
    width: parent.width
    text: failed
        ? config.TranslateLoginFailedWarning || textConstants.loginFailed + "!"
        : keyboard.capsLock
            ? config.TranslateCapslockWarning || textConstants.capslockWarning
            : null

    horizontalAlignment: Text.AlignHCenter
    font.pointSize: root.font.pointSize * 0.8
    font.italic: true
    color: root.palette.text
    opacity: 0

    states: [
        State {
            name: "fail"
            when: failed
            PropertyChanges {
                target: errorMessage
                opacity: 1
            }
        },
        State {
            name: "capslock"
            when: keyboard.capsLock
            PropertyChanges {
                target: errorMessage
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                properties: "opacity"
                duration: 100
            }
        }
    ]
}
