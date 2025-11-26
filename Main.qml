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

import Qt5Compat.GraphicalEffects

import SddmComponents 2.0 as SDDM

import "Components"
import "Components/Input"

Pane {
    id: root

    readonly property url assetsURL: Qt.resolvedUrl("./Assets")

    function toggleState() {
        clock.state = clock.state === "hidden" ? "visible" : "hidden"
        inputs.state = inputs.state === "hidden" ? "visible" : "hidden"

        inputFocusScope.focus = inputs.state === "visible"
    }

    height: config.ScreenHeight || Screen.height
    width: config.ScreenWidth || Screen.ScreenWidth

    padding: config.ScreenPadding

    palette {
        button: "transparent"
        highlight: config.AccentColor
        text: "white"
        buttonText: "white"
        window: "#292c2e"
        placeholderText: Qt.rgba(1,1,1,0.2)
    }

    font {
        family: config.Font
        pointSize: parseInt(height / 80)
    }

    focus: true

    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Space ||
            event.key === Qt.Key_Return ||
            event.key === Qt.Key_Enter) {
                toggleState()
        }
    }

    SDDM.TextConstants { id: textConstants }

    Item {
        id: sizeHelper
        anchors.fill: parent

        Image {
            id: backgroundImage
            width: parent.width
            height: parent.height
            anchors.centerIn: parent

            horizontalAlignment: config.BackgroundImageHAlignment === "left" ?
                                 Image.AlignLeft :
                                 config.BackgroundImageHAlignment === "right" ?
                                 Image.AlignRight : Image.AlignHCenter

            verticalAlignment: config.BackgroundImageVAlignment === "top" ?
                               Image.AlignTop :
                               config.BackgroundImageVAlignment === "bottom" ?
                               Image.AlignBottom : Image.AlignVCenter

            source: config.background || config.Background
            fillMode: config.ScaleImageCropped === "true" ? Image.PreserveAspectCrop : Image.PreserveAspectFit
            asynchronous: true
            cache: true
            clip: true
            mipmap: true
        }

        GaussianBlur {
            id: blur
            source: backgroundImage
            radius: config.BlurRadius
            samples: config.BlurRadius * 2 + 1
            cached: true
            x: inputs.x
            y: inputs.y
            opacity: inputs.opacity
            anchors.fill: parent
        }

        Clock {
            id: clock
            state: "visible"
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            rotation: 90
        }

        MouseArea {
            anchors.fill: parent
            onClicked: toggleState()
        }

        FocusScope {
            id: inputFocusScope
            anchors.fill: parent

            Inputs {
                id: inputs
                state: "hidden"
                width: parent.width / 5
                anchors.centerIn: parent
            }
        }

        FocusScope {
            id: systemButtonsFocusScope
            anchors.fill: parent

            SystemButtons {
                id: systemButtons
                exposedSession: inputs.exposeSession
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: height / 2
                }
            }
        }
    }
}
