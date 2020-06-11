import QtQuick 2.0
import QtQuick.Controls 2.5
import "."


StackView {
    visible: true
    id: addBook
    signal pageExit

    Rectangle{
        id: addBookRect
        signal pageExit
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
            //anchors.fill: parent
            anchors{
                top: parent.top
                left: parent.left
            }


        }

        Button{
            id: addBookButton
            anchors.top: abText.bottom
            text: "Takaisin"

        }

        Connections{
            target: addBookButton
            onClicked: addBook.pageExit
        }
    }


}
