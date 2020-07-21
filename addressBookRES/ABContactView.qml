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
     //   id: abContactView


    // Component can only have one child, so wrapping everything in Item works around that.
        Item{

            Component.onCompleted: {

                if(currentIndex >= 0){
                    var jsonObject = abStack.jsonABData[currentIndex]
                    abContactViewIdField.text = jsonObject["id"]
                    abContactViewFirstNameField.text = jsonObject["firstname"]
                    abContactViewLastNameField.text = jsonObject["lastname"]
                    abContactViewNumberField.text = jsonObject["mobile"]
                    abContactViewEmailField.text = jsonObject["email"]
                }
//                }else if(abStack.state === "ADD"){
                if(abStack.state == "ADD"){
                    abContactViewTitle.text = AppStyle.abAddUser

                    abContactViewIdText.color = "gray"

                    abContactViewIdField.clear()
                    abContactViewFirstNameField.clear()
                    abContactViewLastNameField.clear()
                    abContactViewNumberField.clear()
                    abContactViewEmailField.clear()

                }else if(abStack.state === "UPDATE"){
                    abContactViewTitle.text = "Update contact"


                }else if(abStack.state === "VIEW"){
                    if(Utils.debugMode) console.log("ABContactView.qml:Componen.onCompleted-> Run")
                    abContactViewTitle.text = "View contact"
                    abContactViewIdField.readOnly = true
                    abContactViewFirstNameField.readOnly = true
                    abContactViewLastNameField.readOnly = true
                    abContactViewNumberField.readOnly = true
                    abContactViewEmailField.readOnly = true

                }else if(abStack.state === "SEARCH"){
                    abContactViewTitle.text = "Search contact"

                }else if(Number(abJSONModel.count) === 0){
                    Utils.getDataFromCloud(AppStyle.abURLAddressBook)
                    currentIndex = 0
                }

            }    

            Rectangle{
            color: AppStyle.appBackgroundColor
            anchors.fill: parent
                Text{
                    id: abContactViewTitle
                    text: "Add/Update Contact"
                    color: "white"
                    font.pointSize: 27
                    anchors{
                        top: parent.top
                        topMargin: 30
                        //
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                GridLayout{
                    id: abContactGridView
                    rows: 6
                    columns: 2

                    width: parent.width
                    anchors{
                        //fill: parent
                        top: abContactViewTitle.bottom
                        topMargin: 40
                    }



                    Text{

                        id: abContactViewIdText
                        color: AppStyle.appTextColor
                        text: "id: "
                        font.pointSize: AppStyle.appDefaultFontSize
                        Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewFirstColumnWidth                        

                    }
//                        Rectangle{
//                            color: "white"

                        TextField{
                            id: abContactViewIdField
                            color: AppStyle.appTextColor
                            readOnly: true

                        }
//                        }



                    Text{

                        id: abContactViewFirstNameText
                        color: AppStyle.appTextColor
                        text: "Firstname: "
                        Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewFirstColumnWidth
                        Layout.row: 1
//                            Layout.column: 0
                        font.pointSize: AppStyle.appDefaultFontSize


                    }
                    // Background for text removed for now, didn't behave nicely.
//                        Rectangle{
//                            color: "whitesmoke"
//                            width: abContactViewFirstNameField.width + 10
//                            height: abContactViewFirstNameField.height
//                            radius: 5

                        TextField{
                            id: abContactViewFirstNameField
                            Layout.columnSpan: AppStyle.abContactViewSecondColumnSpan
                            Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewSecondColumnWidth
                            color: AppStyle.appTextColor
                            focus: true

                            //background: "whitesmoke"
                            //Layout.alignment: right
                        }
//                        }

                    Text{

                        id: abContactViewLastNameText
                        color: AppStyle.appTextColor
                        text: "Lastname: "
                        Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewFirstColumnWidth
                        Layout.row: 2
                        font.pointSize: AppStyle.appDefaultFontSize

                    }
                    TextField{
                        id: abContactViewLastNameField
                        color: AppStyle.appTextColor
                        Layout.columnSpan: AppStyle.abContactViewSecondColumnSpan
                        Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewSecondColumnWidth
                    }

                    Text{

                        id: abContactViewNumberText
                        color: AppStyle.appTextColor
                        text: "Phone: "
                        Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewFirstColumnWidth
                        Layout.row: 3
                        font.pointSize: AppStyle.appDefaultFontSize


                    }
                    TextField{
                        id: abContactViewNumberField
                        color: AppStyle.appTextColor
                        Layout.columnSpan: AppStyle.abContactViewSecondColumnSpan
                        Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewSecondColumnWidth
                    }
                    Text{

                        id: abContactViewEmailText
                        color: AppStyle.appTextColor
                        text: "Email: "
                        Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewFirstColumnWidth
                        Layout.row: 4
                        font.pointSize: AppStyle.appDefaultFontSize

                    }
                    TextField{
                        id: abContactViewEmailField
                        color: AppStyle.appTextColor
                        Layout.columnSpan: AppStyle.abContactViewSecondColumnSpan
                        Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewSecondColumnWidth
                    }



                } //GridLayout

            ABContactButtonView{
                id: abContactButtonView
            }

            }//Rectangle
        }//Item
}//Component
