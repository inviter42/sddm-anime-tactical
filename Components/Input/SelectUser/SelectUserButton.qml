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

Button {
    id: usernameIcon
    width: selectUser.height * 0.8
    height: parent.height
    anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
    }
    icon {
        source: Qt.resolvedUrl(`${root.assetsURL}/User.svgz`)
        width: parent.height * 0.25
        height: parent.height * 0.25
        color: root.palette.text
    }
    display: AbstractButton.IconOnly
    enabled: false
    background: Rectangle {
        color: "transparent"
        border.color: "transparent"
    }
}
