import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
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
    property int colNum : 5
    property int contactViewFirstColumnWidth: 6


    ListModel{
        id: abJSONModel
    }

    Component{
        id: abAddressList     

                        MouseArea {

                           onClicked: console.log("Clicked: id: "+ id +" "+ lastname +", "+ firstname +" ")
                           width:  childrenRect.width
                           height: childrenRect.height

                            RowLayout{
                                spacing: 10
                                Text {
                                  color: AppStyle.appTextColor
                                  font.pixelSize: AppStyle.appDefaultFontSize
                                  text: (id).pad(3) + ": "
                                  horizontalAlignment: Text.AlignRight

                                }
                                Text {
                                  color: AppStyle.appTextColor
                                  font.pixelSize: AppStyle.appDefaultFontSize
                                  text: lastname +", "


                                }
                                Text {
                                  color: AppStyle.appTextColor
                                  font.pixelSize: AppStyle.appDefaultFontSize
                                  text: firstname


                                }
                            }//RowLayout
                    }//MouseArea
    }//Component

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

                    }//Grid

                }//Rectangle
        }//Item
    }//Component

    Component{
            id: abAddressView
        // Component can only have one child, so wrapping everything in Item works around that, grandchildren  > children ?


                Item{

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
                            font.pointSize: AppStyle.appInfoFontSize
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
                                    text: "PlaceHolder"
                                    onClicked:  console.log("No.")

                                }

                                Button{
                                    id: abAddressViewPlaceholderButton
                                    width: AppStyle.abButtonWidth
                                    text: "Placeholder"
                                    onClicked: console.log("Nope.")
                                }

                                Button{
                                    id: abAddressViewPrevButton
                                    width: AppStyle.abButtonWidth
                                    text: AppStyle.abReturnToMain
                                    onClicked: push(abMainView)
                                }
                        }


                        // Just counter for testing purposes for how many contacts there are
                        Text{
                            id: abCounterText
                            anchors.top: abAddressViewGrid.bottom
                            //anchors.right: parent.right
                            font.pointSize: AppStyle.appDefaultFontSize
                            color: "white"
                            width: parent.width
                            text: "Addressess in database: " + abJSONModel.count
                        }


                        Rectangle{
                            //anchors.fill: abAddressViewScroll
                            color: "grey"
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 10
                            anchors.top: abCounterText.bottom
                            width: parent.width
                            //implicitHeight: abAddressListView.contentHeight



                            ScrollView{
                                id: abAddressViewScroll
                                height: parent.height
                                width: parent.width - 20
                                //clip: true
                                //padding: 10




                                ListView {
                                        id: abAddressListView
                                        anchors.top: parent.top
                                        //Screws up
                                        boundsBehavior: Flickable.StopAtBounds
                                        clip: true
                                        width: parent * 0.95
                                        //height: contentHeight
                                        visible: true
                                        model: abJSONModel
                                        delegate: abAddressList
                                }
                            }//ScrollView
                        }//Rectangle

                }//Rectangle
            }//Item
    }//Component

    Component{
            id: abContactView
        // Component can only have one child, so wrapping everything in Item works around that, grandchildren  > children ?
            Item{
                Rectangle{

                color: AppStyle.appBackgroundColor
                anchors.fill: parent
                    Text{
                        text: "Add/Update Contact"
                        font.pointSize: 27
                        anchors.top: parent.top
                    }

                    GridLayout{
                        rows: 6
                        columns: 6

                        width: parent.width
                        anchors{
                            //fill: parent

                            margins: 10
                        }


                        Text{

                            id: abContactViewIdText
                            color: AppStyle.appTextColor
                            text: "id: "
                            font.pointSize: AppStyle.appDefaultFontSize
                            width: parent.width / contactViewFirstColumnWidth
//                            fontSizeMode: Text.FixedSize
//                            verticalAlignment: Text.AlignVCenter
//                            horizontalAlignment: Text.AlignHCenter

                        }
                        TextField{
                            text: "Testi"
                        }

                        Text{

                            id: abContactViewFirstNameText
                            color: AppStyle.appTextColor
                            text: "Firstname: "
                            width: parent.width / contactViewFirstColumnWidth
                            Layout.row: 1
//                            Layout.column: 0
                            font.pointSize: AppStyle.appDefaultFontSize
//                            fontSizeMode: Text.FixedSize
//                            verticalAlignment: Text.AlignVCenter
//                            horizontalAlignment: Text.AlignHCenter

                        }
                        TextField{
                            text: "Testi2"
                            Layout.columnSpan: colNum
                        }

                        Text{

                            id: abContactViewLastNameText
                            color: AppStyle.appTextColor
                            text: "Lastname: "
                            width: parent.width / contactViewFirstColumnWidth
                            Layout.row: 2
//                            Layout.column: 0
                            font.pointSize: AppStyle.appDefaultFontSize
//                            fontSizeMode: Text.FixedSize
//                            verticalAlignment: Text.AlignVCenter
//                            horizontalAlignment: Text.AlignHCenter
                        }
                        TextField{
                            text: "Testi3"
                            Layout.columnSpan: colNum
                        }

                        Text{

                            id: abContactViewNumberText
                            color: AppStyle.appTextColor
                            text: "Phone: "
                            width: parent.width / contactViewFirstColumnWidth
                            Layout.row: 3
//                            Layout.column: 0
                            font.pointSize: AppStyle.appDefaultFontSize
//                            fontSizeMode: Text.FixedSize
//                            verticalAlignment: Text.AlignVCenter
//                            horizontalAlignment: Text.AlignHCenter

                        }
                        TextField{
                            text: "Testi4"
                            Layout.columnSpan: colNum
                        }
                        Text{

                            id: abContactViewEmailText
                            color: AppStyle.appTextColor
                            text: "Email: "
                            width: parent.width / contactViewFirstColumnWidth
                            Layout.row: 4
//                            Layout.column: 0
                            font.pointSize: AppStyle.appDefaultFontSize
//                            fontSizeMode: Text.FixedSize
//                            verticalAlignment: Text.AlignVCenter
//                            horizontalAlignment: Text.AlignHCenter

                        }
                        TextField{
                            text: "Testi5"
                            Layout.columnSpan: colNum
                        }



                    } //GridLayout

                Row{
                    anchors.bottom: parent.bottom
                    anchors.margins: 20

                    Button{
                        id: abContactViewPrevButton
                        text: AppStyle.abReturnToMain
//                        Layout.row: 5
//                        Layout.column: 3
                        onClicked: {
                            push(abMainView)
                         }
                    }
                }

                }//Rectangle
            }//Item
    }//Component
}//StackView
