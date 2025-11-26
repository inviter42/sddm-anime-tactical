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

// issues fetching KB layout list, suspended for now
Row {
    id: settingsButtonsContainer
    spacing: 6

    component ButtonComponent: Button {
        id: button

        property int appearAnimationDelay: 400
        property string iconName


        state: settingsButtonsContainer.state
        focus: true

        hoverEnabled: true
        display: AbstractButton.IconOnly

        icon {
            source: Qt.resolvedUrl(`${root.assetsURL}/${button.iconName}`)
            width: 26
            height: 26
            color: root.palette.text
        }

        background: Rectangle {
            color: "white"
            opacity: parent.pressed ? 0.2 : (parent.hovered || parent.activeFocus) ? 0.1 : 0
            implicitWidth: parent.icon.width
            implicitHeight: parent.icon.height
            radius: 6
        }

        states: [
            State {
                name: "hidden"
                PropertyChanges {
                    target: button
                    y: 30 + settingsButtonsContainer.bottomPadding
                    visible: false
                }
            },
            State {
                name: "visible"
                PropertyChanges {
                    target: button
                    y: 0
                    visible: true
                }
            }
        ]

        transitions: [
            Transition {
                reversible: true

                SequentialAnimation {
                    PauseAnimation { duration: button.appearAnimationDelay }
                    ParallelAnimation {
                        NumberAnimation { properties: "y"; duration: 50; easing.type: Easing.Linear }
                    }
                }
            }
        ]
   }

    ButtonComponent {
        appearAnimationDelay: 550
        iconName: 'Globe.svgz'
        onClicked: {
            // kb.text = 'upd:' + JSON.stringify(keyboard)
        }
    }

    ButtonComponent {
        appearAnimationDelay: 400
        iconName: 'Cog.svgz'
    }
}
