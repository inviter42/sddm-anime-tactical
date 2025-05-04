import QtQuick
import QtQuick.Controls

Button {
    id: loginButton
    enabled: config.AllowEmptyPassword === "true" || username.text != "" && password.text != ""
    anchors.horizontalCenter: parent.horizontalCenter
    text: config.TranslateLogin || textConstants.login
    height: root.font.pointSize * 3
    implicitWidth: parent.width
    hoverEnabled: true

    contentItem: Text {
        text: parent.text
        color: config.OverrideLoginButtonTextColor != ""
            ? config.OverrideLoginButtonTextColor
            : root.palette.highlight.hslLightness >= 0.7
                ? "#444"
                : "white"

        font.pointSize: root.font.pointSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        opacity: 0.5
    }

    background: Rectangle {
        id: buttonBackground
        color: "white"
        opacity: 0.2
        radius: config.RoundCorners || 0
    }

    states: [
        State {
            name: "pressed"
            when: loginButton.down

            PropertyChanges {
                target: buttonBackground
                color: Qt.darker(root.palette.highlight, 1.1)
                opacity: 1
            }
            PropertyChanges {
                target: loginButton.contentItem
            }
        },
        State {
            name: "hovered"
            when: loginButton.hovered

            PropertyChanges {
                target: buttonBackground
                color: Qt.lighter(root.palette.highlight, 1.15)
                opacity: 1
            }
            PropertyChanges {
                target: loginButton.contentItem
                opacity: 1
            }
        },
        State {
            name: "focused"
            when: loginButton.activeFocus

            PropertyChanges {
                target: buttonBackground
                color: Qt.lighter(root.palette.highlight, 1.2)
                opacity: 1
            }
            PropertyChanges {
                target: loginButton.contentItem
                opacity: 1
            }
        },
        State {
            name: "enabled"
            when: loginButton.enabled

            PropertyChanges {
                target: buttonBackground;
                color: root.palette.highlight;
                opacity: 1
            }
            PropertyChanges {
                target: loginButton.contentItem;
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                properties: "opacity, color";
                duration: 300
            }
        }
    ]
}
