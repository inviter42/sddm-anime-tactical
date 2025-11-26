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

import "./SelectUser"

Column {
    id: inputContainer

    property bool failed

    property alias exposeSession: sessionSelect.exposeSession

    readonly property Connections sddmConnections: Connections {
        target: sddm

        function onLoginFailed() {
            failed = true
            password.text = ''

            if (resetError.running) {
                resetError.stop()
                resetError.start()
            } else {
                resetError.start()
            }
        }
    }

    function login() {
        if (config.AllowBadUsernames === "false") {
            sddm.login(username.text.toLowerCase(), password.text, sessionSelect.selectedSession)
        } else {
            sddm.login(username.text, password.text, sessionSelect.selectedSession)
        }
    }

    spacing: 8

    states: [
        State {
            name: "hidden"
            PropertyChanges {
                target: inputContainer
                opacity: 0
                visible: false
            }
        },
        State {
            name: "visible"
            PropertyChanges {
                target: inputContainer
                opacity: 1
                visible: true
            }
        }
    ]

    transitions: [
        Transition {
            reversible: true

            SequentialAnimation {
                PauseAnimation { duration: 120 }
                ParallelAnimation {
                    NumberAnimation { properties: "anchors.verticalCenterOffset"; duration: 500; easing.type: Easing.InCubic }
                    NumberAnimation { properties: "opacity"; duration: 200; easing.type: Easing.Linear }
                }
            }
        }
    ]

    Keys.onEscapePressed: {
        inputFocusScope.focus = false
        root.toggleState()
    }

    UserNameTextField {
        id: username

        onFocusChanged: {
            if (focus)
                selectAll()
        }

        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_return || event.key === Qt.Key_Enter) {
                event.accepted = true
                login()
            }
        }

        KeyNavigation.down: password

        SelectUserComboBox {
            id: selectUser

            onActivated: {
                username.text = currentText
            }

            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Down && !popup.opened)
                    username.forceActiveFocus();

                if ((event.key === Qt.Key_Up || event.key === Qt.Key_Left) && !popup.opened)
                    popup.open();
            }

            KeyNavigation.down: username
            KeyNavigation.right: username
        }
    }

    PasswordTextField {
        id: password
        echoMode: revealSecret.pressed ? TextInput.Normal : TextInput.Password
        height: root.font.pointSize * 4.5
        focus: config.ForcePasswordFocus === "true" && inputContainer.state === "visible"

        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                event.accepted = true
                login()
            }

            if (event.key === Qt.Key_X && event.modifiers & Qt.ControlModifier) {
                text = '' // ctrl+x clears the input
            }
        }

        KeyNavigation.down: loginButton

        Button {
            id: revealSecret
            visible: parent.text !== ""
            hoverEnabled: true
            display: AbstractButton.IconOnly
            icon {
                source: Qt.resolvedUrl(`${root.assetsURL}/Eye.svgz`)
                width: 18
                height: 18
                color: Qt.rgba(
                    root.palette.text.r,
                    root.palette.text.g,
                    root.palette.text.b,
                    parent.pressed ? 0.7 : 0.5
                )
            }

            background: Rectangle {
                color: "white"
                opacity: parent.pressed ? 0.2 : parent.hovered || parent.focus ? 0.1 : 0
                implicitWidth: parent.icon.width
                implicitHeight: parent.icon.height
                radius: 6
            }

            anchors {
                right: parent.right
                rightMargin: 18
                verticalCenter: parent.verticalCenter
            }
        }
    }

    ErrorMessageLabel {
        id: errorMessage
    }

    LoginButton {
        id: loginButton
        enabled: config.AllowEmptyPassword === "true" || username.text !== "" && password.text !== ""

        onClicked: login()

        Keys.onReturnPressed: login()
        Keys.onEnterPressed: login()
        KeyNavigation.down: sessionSelect.exposeSession
    }

    SessionButton {
        id: sessionSelect
        textConstantSession: textConstants.session
        loginButtonWidth: loginButton.background.width
    }

    Timer {
        id: resetError
        interval: 2000
        onTriggered: failed = false
        running: false
    }
}
