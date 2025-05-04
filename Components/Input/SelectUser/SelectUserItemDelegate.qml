import QtQuick
import QtQuick.Controls

ItemDelegate {
    width: parent.width
    anchors.horizontalCenter: parent.horizontalCenter
    contentItem: Text {
        text: model.name
        font {
            pointSize: root.font.pointSize * 0.8
            capitalization: Font.Capitalize
        }
        color: selectUser.highlightedIndex === index
            ? root.palette.highlight.hslLightness >= 0.7
                ? "#444"
                : "white"
                    : root.palette.window.hslLightness >= 0.8
                    ? root.palette.highlight.hslLightness >= 0.8
                        ? "#444"
                        : root.palette.highlight
            : "white"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    highlighted: parent.highlightedIndex === index
    background: Rectangle {
        color: selectUser.highlightedIndex === index ? root.palette.highlight : "transparent"
    }
}
