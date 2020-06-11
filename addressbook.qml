import QtQuick 2.0
import QtQuick.Controls 2.5
import "."


StackView {
    visible: true
    id: addBook

    Rectangle{
        color: AppStyle.appBackgroundColor
        anchors.fill: parent

        Text{
            focus: true
            id: abText
            color: AppStyle.appTextColor
            text: "Testi"
            font.pointSize: 27
            fontSizeMode: Text.FixedSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
        }

    }
}
