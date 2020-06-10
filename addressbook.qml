import QtQuick 2.0
import QtQuick.Controls 2.5

StackView {
    visible: true
    id: addBook

    Rectangle{
        color: "white"
        anchors.fill: parent

        Text{
            focus: true
            id: abText
            color: "black"
            text: "Testi"
            font.pointSize: 27
            fontSizeMode: Text.FixedSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
        }

    }
}
