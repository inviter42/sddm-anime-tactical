import QtQuick 2.11
import QtQuick.Controls 2.4

TextField {
    anchors.centerIn: parent
    height: root.font.pointSize * 3
    width: parent.width
    selectByMouse: true
    echoMode: revealSecret.checked ? TextInput.Normal : TextInput.Password
    placeholderText: config.TranslatePlaceholderPassword || textConstants.password
    horizontalAlignment: TextInput.AlignHCenter
    passwordCharacter: "•"
    passwordMaskDelay: config.ForceHideCompletePassword == "true" ? undefined : 1000
    renderType: Text.QtRendering

    background: Rectangle {
        color: "transparent"
        border.color: root.palette.text
        border.width: parent.activeFocus ? 2 : 1
        radius: config.RoundCorners || 0
    }
}
