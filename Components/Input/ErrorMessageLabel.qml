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
