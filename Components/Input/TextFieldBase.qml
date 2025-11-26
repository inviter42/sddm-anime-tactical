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
import QtQuick.Shapes

TextField {
    id: tf

    property alias shapePath: shapePath

    width: parent.width
    height: root.font.pointSize * 4
    selectByMouse: true
    renderType: Text.QtRendering

    background: Rectangle {
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: Qt.rgba(0.11, 0.16, 0.18, 0.8) }
            GradientStop { position: 1; color: "transparent" }
        }
    }

    Shape {
        id: shape
        anchors.fill: parent

        ShapePath {
            id: shapePath
            strokeStyle: ShapePath.SolidLine
            strokeWidth: 2
            strokeColor: "transparent"
            fillColor: "transparent"
            PathLine { x: 8; y: 0 }
            PathMove { x: tf.width - 8; y: 0 }
            PathLine { x: tf.width; y: 0 }
            PathLine { x: tf.width; y: 8 }
            PathMove { x: tf.width; y: tf.height - 8 }
            PathLine { x: tf.width; y: tf.height }
            PathLine { x: tf.width - 8; y: tf.height }
            PathMove { x: 8; y: tf.height }
            PathLine { x: 0; y: tf.height }
            PathLine { x: 0; y: tf.height - 8 }
            PathMove { x: 0; y: 8 }
            PathLine { x: 0; y: 0 }
        }
    }
}
