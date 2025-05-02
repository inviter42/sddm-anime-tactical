//
// This file is part of SDDM Sugar Candy.
// A theme for the Simple Display Desktop Manager.
//
// Copyright (C) 2018–2020 Marian Arlt
//
// SDDM Sugar Candy is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the
// Free Software Foundation, either version 3 of the License, or any later version.
//
// You are required to preserve this and any additional legal notices, either
// contained in this file or in other files that you received along with
// SDDM Sugar Candy that refer to the author(s) in accordance with
// sections §4, §5 and specifically §7b of the GNU General Public License.
//
// SDDM Sugar Candy is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with SDDM Sugar Candy. If not, see <https://www.gnu.org/licenses/>
//

import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

import SddmComponents 2.0 as SDDM

import "Components"
import "Components/Input"

Pane {
    id: root

    /************************************ TODO ************************************/
    /* 1. See into SystemButtons issue (sddm not showing them as available).
        Need to in live env to make sure it's not a cli command issue.

    /* 2. ctrl + x/c doesn't work specifically in Password field. It should work out of the box.
        Something is eating inputs there.

    /* 3. Password placeholder text has a larger font size than user field.

    /* 4. Find better svg icons for SystemButton. Current ones are ugly and
        unreadable without labels.

    /* 5. Play with Input fields styles.

    /* 6. Find better place for Session dropdown.

    /* 7. Session dropdown can use better styling.

    /******************************************************************************/


    readonly property url assetsURL: Qt.resolvedUrl("./Assets")


    readonly property bool leftleft: config.HaveFormBackground == "true" &&
                            config.PartialBlur == "false" &&
                            config.FormPosition == "left" &&
                            config.BackgroundImageHAlignment == "left"

    readonly property bool leftcenter: config.HaveFormBackground == "true" &&
                              config.PartialBlur == "false" &&
                              config.FormPosition == "left" &&
                              config.BackgroundImageHAlignment == "center"

    readonly property bool rightright: config.HaveFormBackground == "true" &&
                              config.PartialBlur == "false" &&
                              config.FormPosition == "right" &&
                              config.BackgroundImageHAlignment == "right"

    readonly property bool rightcenter: config.HaveFormBackground == "true" &&
                               config.PartialBlur == "false" &&
                               config.FormPosition == "right" &&
                               config.BackgroundImageHAlignment == "center"


    function toggleState() {
        clock.state = clock.state == "hidden" ? "visible" : "hidden"
        input.state = input.state == "hidden" ? "visible" : "hidden"
    }

    height: config.ScreenHeight || Screen.height
    width: config.ScreenWidth || Screen.ScreenWidth

    LayoutMirroring.enabled: config.ForceRightToLeft == "true" ? true : Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    padding: config.ScreenPadding

    palette {
        button: "transparent"
        highlight: config.AccentColor
        text: config.MainColor
        buttonText: config.MainColor
        window: config.BackgroundColor
    }

    font {
        family: config.Font
        pointSize: config.FontSize !== "" ? config.FontSize : parseInt(height / 80)
    }

    focus: true

    Keys.onSpacePressed: {
        clock.state = "hidden"
        input.state = "visible"
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

            horizontalAlignment: config.BackgroundImageHAlignment == "left" ?
                                 Image.AlignLeft :
                                 config.BackgroundImageHAlignment == "right" ?
                                 Image.AlignRight : Image.AlignHCenter

            verticalAlignment: config.BackgroundImageVAlignment == "top" ?
                               Image.AlignTop :
                               config.BackgroundImageVAlignment == "bottom" ?
                               Image.AlignBottom : Image.AlignVCenter

            source: config.background || config.Background
            fillMode: config.ScaleImageCropped == "true" ? Image.PreserveAspectCrop : Image.PreserveAspectFit
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
            x: input.x
            y: input.y
            opacity: input.opacity
            anchors.fill: parent
        }

        Rectangle {
            id: tintLayer
            anchors.fill: parent
            width: parent.width
            height: parent.height
            color: "black"
            opacity: config.DimBackgroundImage
            z: 1
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

        Input {
            id: input
            state: "hidden"
            width: parent.width / 2.5
            anchors.centerIn: parent
        }

        SystemButtons {
            id: systemButtons
            exposedSession: input.exposeSession
            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 6
                topMargin: 6
            }
            // temp
            transformOrigin: Item.TopLeft
            transform: Scale { xScale: 0.5; yScale: 0.5 }
        }
    }

    Text {
        font.pixelSize: 80
        id: testText
        text: "test"
        color: "red"
        anchors {
            bottom: parent.bottom
        }
    }
}
