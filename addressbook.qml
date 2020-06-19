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

    ListModel{
        id: abJSONModel
    }

    Component{
        id: abAddressList
        Row {
                    //spacing: 10
                    ListElement {
                        color: AppStyle.appTextColor
                        font.pixelSize: 24
                        text: "Nimi: "+lastname +", "+firstname+" "
                        //horizontalAlignment: horizontalAlignment
                    }

                    Text {
                        color: AppStyle.appTextColor
                        text: firstname

                    }
                }
    }

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


                Item{
                    //anchors.fill: parent
                    //implicitHeight: childrenRect.height
                    //width: parent.width
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
                            id: abAddressViewGrid
                            width: implicitWidth
                            height: implicitHeight
                            rows: 2
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
                                    id: abAddressViewDataOutButton
                                    width: AppStyle.abButtonWidth
                                    text: "Populate"
                                    onClicked:  console.log("Helvetti")

                                }

                                Button{
                                    id: abAddressViewPlaceholderButton
                                    width: AppStyle.abButtonWidth
                                    text: "Placeholder"
                                   //onClicked:
                                }

                                Button{
                                    id: abAddressViewPrevButton
                                    width: AppStyle.abButtonWidth
                                    text: AppStyle.abReturnToMain
                                    onClicked: push(abMainView)
                                }
                        }

                        Text{
                            id: abCounterText
                            anchors.top: abAddressViewGrid.bottom
                            color: "white"
                            width: parent.width
                            text: abJSONModel.count
                        }


                        Rectangle{
                            //anchors.fill: abAddressViewScroll
                            color: "grey"
                            anchors.bottom: parent.bottom
                            anchors.top: abAddressViewGrid.bottom
                            width: parent.width
                            //implicitHeight: abAddressListView.contentHeight



                            ScrollView{
                                id: abAddressViewScroll
                                height: children.height
                                width: parent.width
                                clip: true

                                // Just counter for testing purposes for how many contacts there are


                                ListView {
                                        id: abAddressListView
                                        anchors.top: parent.top
                                        //Screws up
                                        //clip: true
                                        width: parent * 0.95
                                        height: contentHeight
                                        visible: true
                                        model: abJSONModel
                                        delegate: abAddressList
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

                }//Rectangle
            }//Item
    }//Component
}//StackView
