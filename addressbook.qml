import QtQuick 2.0
import QtQuick.Controls 2.5
import "."
import "littlehelper.js" as Utils




StackView {

    id: abStack
// Signals
    signal message(string msg)
    signal returnToMain()

    initialItem: abMainView
    anchors.fill: parent

    visible: true


    // property will store data
     property var jsonData



    Component{
        id: abMainView
        // Component can only have one child, so wrapping everything in Item works around that, child->grandchild?
            Item{
                Rectangle{

                    color: AppStyle.appBackgroundColor
                    anchors{                  
                        fill: parent
                    }

                    Text{

                        id: abMainText
                        color: AppStyle.appTextColor
                        text: AppStyle.abTitle
                        font.pointSize: 27
                        fontSizeMode: Text.FixedSize

                        anchors{
                            top: parent.top
                            margins: AppStyle.abButtonMarging + 10
                            horizontalCenter: parent.horizontalCenter
                        }
                    }

                    Grid{
                        width: implicitWidth
                        height: implicitHeight
                        rows: 2
                        columns: 2
                        rowSpacing: AppStyle.abButtonMarging / 2
                        columnSpacing: AppStyle.abButtonMarging
                        anchors{
                            top: abMainText.bottom
                            horizontalCenter: parent.horizontalCenter
                            topMargin: 20
                        }

                            Button{
                                id: abGetDataButton
                                width: AppStyle.abButtonWidth
                                text: AppStyle.abGetData
                                onClicked: {
                                    push(abAddressView)
                                }
                            }

                            Button{
                                id: abAddDataButton
                                width: AppStyle.abButtonWidth
                                text: AppStyle.abAddUser
                                onClicked: push(abContactView)

                            }

                            Button{
                                id: abBackToMainButton
                                width: AppStyle.abButtonWidth
                                text: AppStyle.abReturnToMain
                                onClicked: abStack.returnToMain()
                            }

                    }
                }
        }
    }

    Component{
            id: abAddressView
        // Component can only have one child, so wrapping everything in Item works around that, grandchildren  > children ?
            ScrollView{
               // Let's try something else,
                Component.onCompleted: console.log("abAddressView ready") //Utils.getDataFromCloud("https://qtphone.herokuapp.com/contact")

                Rectangle{

                color: AppStyle.appBackgroundColor
                anchors{
                // Didn't work as planned, but I might try again later
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom                   
                }

                    Text{

                        id: abAddressViewTitleText
                        color: AppStyle.appTextColor
                        text: AppStyle.abTitle
                        font.pointSize: 27
                        fontSizeMode: Text.FixedSize

                        anchors{
                            top: parent.top
                            margins: AppStyle.abButtonMarging + 10
                            horizontalCenter: parent.horizontalCenter
                        }
                    }

                    Grid{
                        width: implicitWidth
                        height: implicitHeight
                        rows: 1
                        columns: 2
                        rowSpacing: AppStyle.abButtonMarging / 2
                        columnSpacing: AppStyle.abButtonMarging
                        anchors{
                            top: abAddressViewTitleText.bottom
                            horizontalCenter: parent.horizontalCenter
                            topMargin: 20
                        }

                            Button{
                                id: abGetDataFromCloud
                                width: AppStyle.abButtonWidth
                                text: AppStyle.abGetDataFromCloud
                                onClicked: {
                                    Utils.getDataFromCloud("https://qtphone.herokuapp.com/contact")
                                }
                            }

                            Button{
                                id: abAddressViewPrevButton
                                width: AppStyle.abButtonWidth
                                text: AppStyle.abReturnToMain
                                onClicked: push(abMainView)
                            }
                    }

                    ListView {
                        anchors.fill: parent
                        model: ListModel { id: model}
                        delegate: Text { text: "- " + lastname + ", " + firstname }
                        Component.onCompleted: {

                                    model.clear();

                                    for (var i in jsonData) {
                                        var jsonObject = abStack.jsonData[i]
                                        model.append({lastname = jsonObject["lastname"], firstname = jsonObject["firstname"]})
                                    }
                                }



                    }

            }
        }
    }

    Component{
            id: abContactView
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

                        id: abContactViewText
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
                        id: abContactViewPrevButton
                        anchors.top: abContactViewText.bottom
                        text: "Prev"
                        onClicked: {
                            push(abMainView)
                         }
                    }

                }
            }
        }
}
