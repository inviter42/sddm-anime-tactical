import QtQuick 2.11
import QtQuick.Controls 2.4

import QtGraphicalEffects 1.0

Popup {
        y: parent.height - username.height / 3
        x: config.ForceRightToLeft == "true" ? -loginButton.width + selectUser.width : 0
        rightMargin: config.ForceRightToLeft == "true" ? root.padding + usernameField.width / 2 : undefined
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
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: 10 * config.InterfaceShadowSize
                radius: 20 * config.InterfaceShadowSize
                samples: 41 * config.InterfaceShadowSize
                cached: true
                color: Qt.hsla(0,0,0,config.InterfaceShadowOpacity)
            }
        }

        enter: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1 }
        }
    }
