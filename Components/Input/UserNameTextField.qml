import QtQuick

TextFieldBase {
    id: username
    text: config.ForceLastUser === "true" ? selectUser.currentText : null
    font.capitalization: config.AllowBadUsernames === "false" ? Font.Capitalize : Font.MixedCase
    placeholderText: config.TranslatePlaceholderUsername || textConstants.userName
    horizontalAlignment: TextInput.AlignHCenter
    z: 1

    states: [
        State {
            name: "focused"
            when: username.activeFocus
            PropertyChanges {
                target: shapePath
                strokeColor: root.palette.highlight
            }
            PropertyChanges {
                target: username
                color: root.palette.highlight
            }
        }
    ]
}
