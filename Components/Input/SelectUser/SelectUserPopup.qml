import QtQuick
import QtQuick.Controls

Popup {
        y: parent.height - username.height / 3
        x: config.ForceRightToLeft === "true" ? -loginButton.width + selectUser.width : 0
        rightMargin: config.ForceRightToLeft === "true" ? root.padding + usernameField.width / 2 : undefined
        width: usernameField.width
        implicitHeight: contentItem.implicitHeight
        padding: 10

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight + 20
            model: selectUser.popup.visible ? selectUser.delegateModel : null
            currentIndex: selectUser.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            radius: config.RoundCorners / 2
            color: root.palette.window
        }

        enter: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1 }
        }
    }
