import QtQuick
import QtQuick.Controls

Button {
    id: usernameIcon
    width: selectUser.height * 0.8
    height: parent.height
    anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
        // leftMargin: selectUser.height * 0.125
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
