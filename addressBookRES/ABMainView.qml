import QtQuick 2.4
//import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
//import QtQuick 2.15
import QtQuick.LocalStorage 2.12// as Sql

import "."
import ".."
import "../littlehelper.js" as Utils

Component{
    //id: abMainView

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
                                push(abAddressView)
                            }
                        }

                        Button{
                            id: abAddDataButton
                            width: AppStyle.abButtonWidth
                            text: AppStyle.abAddUser
                            onClicked: {
                                currentIndex = -2
                                push(abContactView)
                            }
                        }

                        Button{
                            id: abSearchButton
                            width: AppStyle.abButtonWidth
                            text: AppStyle.abSearch
                            onClicked: {
                                console.log("Search pushed.")
                            }
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
