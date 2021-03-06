import QtQuick 2.4
//import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
//import QtQuick 2.15
import QtQuick.LocalStorage 2.12// as Sql
import QtWebView 1.1


import "."
import ".."
import "../littlehelper.js" as Utils

Component{
    id: abMainView

    // Component can only have one child, so wrapping everything in Item works around that.
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
                    rows: 3
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
                                //push(abAddressView)
                                if(Utils.debugMode) console.log("Old State: " + abStack.state);
                                abStack.state =  "BROWSE"
                            }
                        }

                        Button{
                            id: abAddDataButton
                            width: AppStyle.abButtonWidth
                            text: AppStyle.abAddUser
                            onClicked: {
                                currentIndex = -2
                                //push(abContactView)
                                if(Utils.debugMode) console.log("Old State: " + abStack.state);
                                abStack.state =  "ADD"
                            }
                        }

                        Button{
                            id: abSearchButton
                            width: AppStyle.abButtonWidth
                            text: AppStyle.abSearch
                            onClicked: {
                                if(Utils.debugMode) console.log("Old State: " + abStack.state);
                                abStack.state = "SEARCH"
                            }
                        }                        

                        Button{
                            id: abBackToMainButton
                            width: AppStyle.abButtonWidth
                            text: AppStyle.abReturnToMain
                            onClicked: abStack.returnToMain()
                        }

                }//Grid

                Grid{
                    width: implicitWidth
                    height: implicitHeight
                    columns: 2

                    rowSpacing: AppStyle.abButtonMarging / 2
                    columnSpacing: AppStyle.abButtonMarging
                    anchors{
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                        bottomMargin: 20
                    }
                    // Way to change settings not implemented yet.
//                    Button{
//                        id: abSettingsButton
//                        width: AppStyle.abButtonWidth
//                        text: "Settings ?"
//                        onClicked: {

//                        }
 //                   }

                    Button{
                        id: abAboutButton
                        width: AppStyle.abButtonWidth
                        text: AppStyle.abAbout
                        onClicked: {
                            if(Utils.debugMode) console.log("Old State: " + abStack.state);
                            //popup.open()
                            abStack.state = "ABOUT"

                        }
                    }
                }// GridView
            }//Rectangle

        }//Item
}//Component


