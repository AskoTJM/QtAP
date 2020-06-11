import QtQuick 2.0
import QtQuick.Controls 2.5
import "."


StackView {
    visible: true
    id: addBook
    signal message(string msg)
    signal returnToMain()
    initialItem: mainAddressView
    anchors.fill: parent


    Component{
        id: mainAddressView
            Item{
                Rectangle{

                color: AppStyle.appBackgroundColor
                anchors.fill: parent

                Text{

                    id: abText
                    color: AppStyle.appTextColor
                    text: "Testi"
                    font.pointSize: 27
                    fontSizeMode: Text.FixedSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                    anchors{
                        top: parent.top
                        left: parent.left
                    }
                }

                Button{
                    id: addBookButton
                    anchors.top: abText.bottom
                    text: "Back to main"
                    onClicked: addBook.returnToMain()
                }

                Button{
                    id: addSecondButton
                    anchors.top: addBookButton.bottom
                    text: "Next"
                    onClicked: {

                        push(secondAddressView)
                     }
                }
            }
        }
    }

    Component{
            id: secondAddressView
            Item{
                Rectangle{

                color: AppStyle.appBackgroundColor
                anchors.fill: parent

                    Text{

                        id: ab2Text
                        color: AppStyle.appTextColor
                        text: "SecondTest"
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
                        id: addPrevButton
                        anchors.top: ab2Text.bottom
                        text: "Prev"
                        onClicked: {
                            push(mainAddressView)
                         }
                    }

                }
            }
        }
}

