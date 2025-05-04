import QtQuick
import QtQuick.Controls

ComboBox {
    id: selectUser
    width: parent.height
    height: parent.height
    anchors.left: parent.left
    z: 2

    model: userModel
    currentIndex: model.lastIndex
    textRole: "name"
    hoverEnabled: true

    contentItem: Item {}

    delegate: SelectUserItemDelegate {}

    indicator: SelectUserButton {
        id: usernameIcon
    }

    popup: SelectUserPopup {}

    background: Rectangle {
        color: "transparent"
        border.width: 0
    }

    states: [
        State {
            name: "pressed"
            when: selectUser.down
            PropertyChanges {
                target: usernameIcon
                icon.color: Qt.lighter(root.palette.highlight, 1.1)
            }
        },
        State {
            name: "hovered"
            when: selectUser.hovered
            PropertyChanges {
                target: usernameIcon
                icon.color: Qt.lighter(root.palette.highlight, 1.2)
            }
        },
        State {
            name: "focused"
            when: selectUser.activeFocus
            PropertyChanges {
                target: usernameIcon
                icon.color: root.palette.highlight
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                properties: "color, border.color, icon.color"
                duration: 150
            }
        }
    ]
}
