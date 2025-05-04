import QtQuick

TextFieldBase {
    id: password
    echoMode: revealSecret.checked ? TextInput.Normal : TextInput.Password
    placeholderText: config.TranslatePlaceholderPassword || textConstants.password
    horizontalAlignment: TextInput.AlignHCenter
    passwordCharacter: "•"
    passwordMaskDelay: config.ForceHideCompletePassword === "true" ? undefined : 1000

    states: [
        State {
            name: "focused"
            when: password.activeFocus
            PropertyChanges {
                target: shapePath
                strokeColor: root.palette.highlight
            }
            PropertyChanges {
                target: password
                color: root.palette.highlight
            }
        }
    ]
}
