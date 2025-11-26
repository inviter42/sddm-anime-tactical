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

ItemDelegate {

    property bool isHighlighted: false

    width: parent ? parent.width : 0
    anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
    contentItem: Text {
        text: model.name
        font.pointSize: root.font.pointSize * 0.8
        color: "white"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    background: Rectangle {
        readonly property Gradient grad: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: Qt.rgba(0.21, 0.26, 0.28, 0.8) }
            GradientStop { position: 1; color: "transparent" }
        }

        color: "transparent"
        gradient: highlighted ? grad : null
        radius: 4
    }
}
