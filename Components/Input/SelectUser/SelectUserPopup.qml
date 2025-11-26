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

import "../"

PopupBase {
    y: parent.height - username.height * 0.2
    implicitWidth: username.width
    implicitHeight: contentItem.implicitHeight

    background: Rectangle {
        radius: 10
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: Qt.rgba(0.21, 0.26, 0.28, 1) }
            GradientStop { position: 1; color: "transparent" }
        }
        anchors.fill: parent
        border {
            width: 1
            color: Qt.hsla(1,1,1,0.1)
        }
    }

    listView {
        model: selectUser.popup.visible ? selectUser.delegateModel : null
        currentIndex: selectUser.highlightedIndex
    }
}
