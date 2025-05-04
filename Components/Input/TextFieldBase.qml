import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

TextField {
    id: tf

    property alias shapePath: shapePath

    height: root.font.pointSize * 4
    width: parent.width
    anchors.centerIn: parent
    selectByMouse: true
    renderType: Text.QtRendering

    background: Rectangle {
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: Qt.rgba(0.11, 0.16, 0.18, 0.8) }
            GradientStop { position: 1; color: "transparent" }
        }
    }

    Shape {
        id: shape
        anchors.fill: parent

        ShapePath {
            id: shapePath
            strokeStyle: ShapePath.SolidLine
            strokeWidth: 2
            strokeColor: "transparent"
            fillColor: "transparent"
            PathLine { x: 8; y: 0 }
            PathMove { x: tf.width - 8; y: 0 }
            PathLine { x: tf.width; y: 0 }
            PathLine { x: tf.width; y: 8 }
            PathMove { x: tf.width; y: tf.height - 8 }
            PathLine { x: tf.width; y: tf.height }
            PathLine { x: tf.width - 8; y: tf.height }
            PathMove { x: 8; y: tf.height }
            PathLine { x: 0; y: tf.height }
            PathLine { x: 0; y: tf.height - 8 }
            PathMove { x: 0; y: 8 }
            PathLine { x: 0; y: 0 }
        }
    }
}
