import QtQuick 2.11
import QtQuick.Controls 2.4

TextField {
    id: username

    text: config.ForceLastUser == "true" ? selectUser.currentText : null
    font.capitalization: config.AllowBadUsernames == "false" ? Font.Capitalize : Font.MixedCase
    placeholderText: config.TranslatePlaceholderUsername || textConstants.userName
    horizontalAlignment: TextInput.AlignHCenter
    renderType: Text.QtRendering

    height: root.font.pointSize * 3
    width: parent.width
    anchors.centerIn: parent
    z: 1

    selectByMouse: true

    background: Rectangle {
        color: "transparent"
        border.color: root.palette.text
        border.width: parent.activeFocus ? 2 : 1
        radius: config.RoundCorners || 0
    }

    states: [
        State {
            name: "focused"
            when: username.activeFocus
            PropertyChanges {
                target: username.background
                border.color: root.palette.highlight
            }
            PropertyChanges {
                target: username
                color: root.palette.highlight
            }
        }
    ]
}
