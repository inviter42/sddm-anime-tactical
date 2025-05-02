import QtQuick 2.11
import QtQuick.Controls 2.4

CheckBox {
    id: revealSecret
    width: parent.width
    hoverEnabled: true

    indicator: Rectangle {
        id: indicator
        anchors {
            left: parent.left
            top: parent.top
            topMargin: 3
            leftMargin: 4
        }
        implicitHeight: root.font.pointSize
        implicitWidth: root.font.pointSize
        color: "transparent"
        border {
            color: root.palette.text
            width: parent.activeFocus ? 2 : 1
        }

        Rectangle {
            id: dot
            anchors.centerIn: parent
            implicitHeight: parent.width - 6
            implicitWidth: parent.width - 6
            color: root.palette.text
            opacity: revealSecret.checked ? 1 : 0
        }
    }

    contentItem: Text {
        id: indicatorLabel
        text: config.TranslateShowPassword || "Show Password"
        anchors {
            verticalCenter: indicator.verticalCenter
            left: indicator.right
            leftMargin: indicator.width / 2
        }
        horizontalAlignment: Text.AlignLeft
        font.pointSize: root.font.pointSize * 0.8
        color: root.palette.text
    }

    background: Rectangle {
        color: "transparent"
        border {
            width: parent.activeFocus ? 1 : 0
            color: parent.activeFocus ? root.palette.text : "transparent"
        }
        height: parent.activeFocus ? 2 : 0
        width: (indicator.width + indicatorLabel.contentWidth + indicatorLabel.anchors.leftMargin + 2)
        anchors {
            top: indicatorLabel.bottom
            left: parent.left
            leftMargin: 3
            topMargin: 8
        }
    }

    states: [
        State {
            name: "pressed"
            when: revealSecret.down
            PropertyChanges {
                target: revealSecret.contentItem
                color: Qt.darker(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: dot
                color: Qt.darker(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: indicator
                border.color: Qt.darker(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: revealSecret.background
                border.color: Qt.darker(root.palette.highlight, 1.1)
            }
        },
        State {
            name: "hovered"
            when: revealSecret.hovered
            PropertyChanges {
                target: indicatorLabel
                color: Qt.lighter(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: indicator
                border.color: Qt.lighter(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: dot
                color: Qt.lighter(root.palette.highlight, 1.1)
            }
            PropertyChanges {
                target: revealSecret.background
                border.color: Qt.lighter(root.palette.highlight, 1.1)
            }
        },
        State {
            name: "focused"
            when: revealSecret.activeFocus
            PropertyChanges {
                target: indicatorLabel
                color: root.palette.highlight
            }
            PropertyChanges {
                target: indicator
                border.color: root.palette.highlight
            }
            PropertyChanges {
                target: dot
                color: root.palette.highlight
            }
            PropertyChanges {
                target: revealSecret.background
                border.color: root.palette.highlight
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                properties: "color, border.color, opacity"
                duration: 150
            }
        }
    ]
}
