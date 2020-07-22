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
//    property var searchBy

    // Component can only have one child, so wrapping everything in Item works around that.
        Item{
            //

            Component.onCompleted: {
                // Most of this code would nice to get into JS-script file for cleaner look,
                // but for now it causes issues and currently it's more important to get everything working.

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
                    Utils.contactStateTo("UPDATE")

                }else if(abStack.state === "VIEW"){
                    if(Utils.debugMode) console.log("ABContactView.qml:Componen.onCompleted-> Run")
                    abStack.state = "VIEW"
                    abContactViewTitle.text = "View contact"
                    abContactViewIdField.readOnly = true
                    abContactViewFirstNameField.readOnly = true
                    abContactViewLastNameField.readOnly = true
                    abContactViewNumberField.readOnly = true
                    abContactViewEmailField.readOnly = true

                }else if(abStack.state === "SEARCH"){
                    abContactViewTitle.text = "Search contact"
                    abContactViewIdField.clear()
                    abContactViewIdField.readOnly = false
                    abContactViewFirstNameField.clear()
                    abContactViewLastNameField.clear()
                    abContactViewNumberField.clear()
                    abContactViewEmailField.clear()

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
                    text: "You shouldn't see this."
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
                            Keys.onReleased: {
                                if(Utils.debugMode) console.log("ABContactView.qml:abContactViewIdField: " + this.text );
                                Utils.searchFromJSON(text,"id",true)
                            }
                            onFocusChanged:{
                                if(activeFocus.toString()){
                                    if(abStack.state === "SEARCH"){
//                                        abContactViewIdText.visible = false
//                                        abContactViewIdField.visible = false
                                        abContactViewFirstNameText.visible = false
                                        abContactViewFirstNameField.visible = false
                                        abContactViewLastNameText.visible = false
                                        abContactViewLastNameField.visible = false
                                        abContactViewNumberText.visible = false
                                        abContactViewNumberField.visible = false
                                        abContactViewEmailText.visible = false
                                        abContactViewEmailField.visible = false
                                        abContactViewScroll.visible = true
//                                        searchBy = "id"

                                    }
                                }


                            }
                        }



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
                            Keys.onReleased: {
                                if(Utils.debugMode) console.log("ABContactView.qml:abContactViewFirstNameField: " + this.text );
                                Utils.searchFromJSON(text,"firstname",false)
                            }
                            //focus: true
                            onFocusChanged:{
                                if(activeFocus.toString()){
                                    if(abStack.state === "SEARCH"){
                                        abContactViewIdText.visible = false
                                        abContactViewIdField.visible = false
//                                        abContactViewFirstNameText.visible = false
//                                        abContactViewFirstNameField = false
                                        abContactViewLastNameText.visible = false
                                        abContactViewLastNameField.visible = false
                                        abContactViewNumberText.visible = false
                                        abContactViewNumberField.visible = false
                                        abContactViewEmailText.visible = false
                                        abContactViewEmailField.visible = false
                                        abContactViewScroll.visible = true
//                                        searchBy = "firstname"

                                    }
                                }

                                if(Utils.debugMode) console.log("ABContactView.qml:abContactViewFirstNameField: Focus: " + activeFocus.toString() )
                            }

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
                        Keys.onReleased: {
                            if(Utils.debugMode) console.log("ABContactView.qml:abContactViewLastNameField: " + this.text );
                            Utils.searchFromJSON(text,"lastname",false)
                        }
                        onFocusChanged:{
                            if(activeFocus.toString()){
                                if(abStack.state === "SEARCH"){
                                    abContactViewIdText.visible = false
                                    abContactViewIdField.visible = false
                                    abContactViewFirstNameText.visible = false
                                    abContactViewFirstNameField.visible = false
//                                    abContactViewLastNameText.visible = false
//                                    abContactViewLastNameField.visible = false
                                    abContactViewNumberText.visible = false
                                    abContactViewNumberField.visible = false
                                    abContactViewEmailText.visible = false
                                    abContactViewEmailField.visible = false
                                    abContactViewScroll.visible = true
//                                    searchBy = "lastname"

                                }
                            }

                        }
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
                        Keys.onReleased: {
                            if(Utils.debugMode) console.log("ABContactView.qml:abContactViewNumberField: " + this.text );
                            Utils.searchFromJSON(text,"mobile",false)
                        }
                        onFocusChanged:{
                            if(activeFocus.toString()){
                                if(abStack.state === "SEARCH"){
                                    abContactViewIdText.visible = false
                                    abContactViewIdField.visible = false
                                    abContactViewFirstNameText.visible = false
                                    abContactViewFirstNameField.visible = false
                                    abContactViewLastNameText.visible = false
                                    abContactViewLastNameField.visible = false
//                                    abContactViewNumberText.visible = false
//                                    abContactViewNumberField.visible = false
                                    abContactViewEmailText.visible = false
                                    abContactViewEmailField.visible = false
                                    abContactViewScroll.visible = true
//                                    searchBy = "mobile"


                                }
                            }

                        }

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
                        Keys.onReleased: {
                            if(Utils.debugMode) console.log("ABContactView.qml:abContactViewEmailField: " + this.text );
                            Utils.searchFromJSON(text,"email",false)
                        }
                        onFocusChanged:{
                            if(activeFocus.toString()){
                                if(abStack.state === "SEARCH"){
                                    abContactViewIdText.visible = false
                                    abContactViewIdField.visible = false
                                    abContactViewFirstNameText.visible = false
                                    abContactViewFirstNameField.visible = false
                                    abContactViewLastNameText.visible = false
                                    abContactViewLastNameField.visible = false
                                    abContactViewNumberText.visible = false
                                    abContactViewNumberField.visible = false
//                                    abContactViewEmailText.visible = false
//                                    abContactViewEmailField.visible = false
                                    abContactViewScroll.visible = true
                                    //Utils.contactSearchSwitch("search");
//                                    searchBy = "email"

                                }
                            }
                        }

                    }

                } //GridLayout

                ScrollView{
                    id: abContactViewScroll
                    //height: parent.height - ( abContactGridView.height + abContactButtonView.height + abContactViewTitle.height + abContactButtonView.topMargin.height )
                    width: parent.width - 20
                    anchors.top: abContactGridView.bottom
                    anchors.topMargin: 10
                    anchors.bottom: abContactButtonView.top
                    visible: false

                    ListView {
                            id: abContactListView
                            anchors.top: parent.top
                            boundsBehavior: Flickable.StopAtBounds
                            clip: true
                            width: parent * 0.95
                            visible: true
                            model: abJSONModel
                            delegate: {
                                if(abContactViewIdField.focus === true ){
                                    abAddressList
                                }else if(abContactViewFirstNameField.focus === true){
                                    abAddressList
                                }else if(abContactViewLastNameField.focus === true){
                                    abAddressList
                                }else if(abContactViewNumberField.focus === true){
                                    abContactSearchMobileList
                                }else if(abContactViewEmailField.focus === true){
                                    abContactSearchEmailList
                                }
                            }

                    }
                }//ScrollView


            ABContactButtonView{
                id: abContactButtonView
                //anchors.bottom: parent.bottom
            }

            }//Rectangle
        }//Item
}//Component
