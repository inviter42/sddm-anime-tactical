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

import QtQuick

import "./SelectUser"

Column {
    id: inputContainer

    property bool failed

    property alias exposeSession: sessionSelect.exposeSession

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

    Keys.onEscapePressed: root.toggleState()

    UserNameFieldWrapper {
        id: usernameField
        anchors.horizontalCenter: parent.horizontalCenter

        SelectUserComboBox {
            id: selectUser

            readonly property var popkey: config.ForceRightToLeft === "true" ? Qt.Key_Right : Qt.Key_Left

            onActivated: {
                username.text = currentText
            }

            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Down && !popup.opened)
                    username.forceActiveFocus();

                if ((event.key === Qt.Key_Up || event.key === popkey) && !popup.opened)
                    popup.open();
            }

            KeyNavigation.down: username
            KeyNavigation.right: username
        }

        UserNameTextField {
            id: username
            onFocusChanged: {
                if (focus)
                    selectAll()
            }
            onAccepted: loginButton.clicked()
            KeyNavigation.down: password
        }
    }

    PasswordFieldWrapper {
        id: passwordField
        anchors.horizontalCenter: parent.horizontalCenter

        PasswordTextField {
            id: password
            focus: config.ForcePasswordFocus === "true" && inputContainer.state === "visible"
            onAccepted: loginButton.clicked()
            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_X && event.modifiers & Qt.ControlModifier && !revealSecret.checked) {
                    text = '' // ctrl+x clears the input
                }
            }

            KeyNavigation.down: revealSecret
        }
    }

    ShowSecretCheckBoxWrapper {
        id: secretCheckBox
        anchors.horizontalCenter: parent.horizontalCenter

        ShowSecretCheckBox {
            id: revealSecret
            Keys.onReturnPressed: toggle()
            Keys.onEnterPressed: toggle()
            KeyNavigation.down: loginButton
        }
    }

    ErrorMessageLabelWrapper {
        anchors.horizontalCenter: parent.horizontalCenter

        ErrorMessageLabel {
            id: errorMessage
        }
    }

    LoginButtonWrapper {
        id: login
        anchors.horizontalCenter: parent.horizontalCenter

        LoginButton {
            id: loginButton
            enabled: config.AllowEmptyPassword === "true" || username.text != "" && password.text != ""

            onClicked: config.AllowBadUsernames === "false"
                ? sddm.login(username.text.toLowerCase(), password.text, sessionSelect.selectedSession)
                : sddm.login(username.text, password.text, sessionSelect.selectedSession)

            Keys.onReturnPressed: clicked()
            Keys.onEnterPressed: clicked()
            KeyNavigation.down: sessionSelect.exposeSession
        }
    }

    SessionButton {
        id: sessionSelect
        textConstantSession: textConstants.session
        loginButtonWidth: loginButton.background.width
    }

    Connections {
        target: sddm

        function onLoginSucceeded() {}
        function onLoginFailed() {
            failed = true

            if (resetError.running) {
                resetError.stop()
                resetError.start()
            } else {
                resetError.start()
            }
        }
    }

    Timer {
        id: resetError
        interval: 2000
        onTriggered: failed = false
        running: false
    }
}
