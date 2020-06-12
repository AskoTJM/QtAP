import QtQuick 2.0
import QtQuick.Controls 2.5
import "."


StackView {

    id: addBook
// Signals
    signal message(string msg)
    signal returnToMain()

    initialItem: mainAddressView
    anchors.fill: parent

    visible: true

    Component{
        id: mainAddressView
        // Component can only have one child, so wrapping everything in Item works around that, child->grandchild?
            Item{
                Rectangle{

                color: AppStyle.appBackgroundColor
                anchors{
                // Didn't work as planned, but I might try again later
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    //bottom: addBookBackToMainButton.top
                }

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
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                        //left: parent.left
                        bottom: parent.bottom

                    }
                    text: "Back to main"
                    onClicked: addBook.returnToMain()
                }

                Button{
                    id: getAddButton
                    anchors.top: abText.bottom
                    text: "Get data"
                    onClicked: {
                        push(dataAddressView)
                     }
                }

                Button{
                    id: addAddButton
                    anchors.top: getAddButton.bottom
                    text: "Add data"
                    onClicked: {
                        push(userAddressView)
                     }
                }
            }
        }
    }

    Component{
            id: dataAddressView
        // Component can only have one child, so wrapping everything in Item works around that, grandchildren  > children ?
            Item{
                Rectangle{

                color: AppStyle.appBackgroundColor
                anchors{
                // Didn't work as planned, but I might try again later
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    //bottom: addBookBackToMainButton.top
                }

                    Text{

                        id: ab2Text
                        color: AppStyle.appTextColor
                        text: "SecondTest"
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

    Component{
            id: userAddressView
        // Component can only have one child, so wrapping everything in Item works around that, grandchildren  > children ?
            Item{
                Rectangle{

                color: AppStyle.appBackgroundColor
                anchors{
                // Didn't work as planned, but I might try again later
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    //bottom: addBookBackToMainButton.top
                }

                    Text{

                        id: ab3Text
                        color: AppStyle.appTextColor
                        text: "ThirdTest"
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

