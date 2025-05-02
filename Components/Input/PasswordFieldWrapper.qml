import QtQuick 2.11

Item {
    id: passwordField
    height: root.font.pointSize * 4.5
    width: parent.width / 2

    states: [
        State {
            name: "focused"
            when: password.activeFocus
            PropertyChanges {
                target: password.background
                border.color: root.palette.highlight
            }
            PropertyChanges {
                target: password
                color: root.palette.highlight
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                properties: "color, border.color"
                duration: 150
            }
        }
    ]
}
