import QtQuick 2.4
//import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
//import QtQuick 2.15
import QtQuick.LocalStorage 2.12// as Sql

import "."
import ".."
import "../littlehelper.js" as Utils

GridLayout{
    anchors.bottom: parent.bottom
    //rows: 3
    columns: 2
    anchors.horizontalCenter: parent.horizontalCenter
    //width: implicitWidth
    //width: ( AppStyle.abButtonWidth + AppStyle.abButtonMarging + AppStyle.abButtonWidth)
    //Layout.horizontalCenter: parent.horizontalCenter
    //Layout.minimumWidth: AppStyle.abButtonMarging + AppStyle.abButtonWidth + AppStyle.abButtonWidth
    height: implicitHeight
    rowSpacing: AppStyle.abButtonMarging / 2
    columnSpacing: AppStyle.abButtonMarging
    //anchors.margins: 20
    //spacing: 10
    //margins: 10

    Component.onCompleted: {
        switch(abStack.state){
            case "SEARCH":
                abContactViewPrevButton.visible = false;
                abContactViewNextButton.visible = false;
                abContactViewSaveButton.visible = false;
                abContactViewSearchBackButton.visible = true;
                break;
            case "UPDATE":
                abContactViewPrevButton.visible = false;
                abContactViewNextButton.visible = false;
                abContactViewEditButton.visible = false;
                abContactViewSaveButton.visible = true;
                break;
            case "ADD":
                abContactViewPrevButton.visible = false;
                abContactViewNextButton.visible = false;
                break;
            case "VIEW":
                abContactViewSaveButton.visible = false;
                abContactViewEditButton.visible = true;
                //abEmptyButton.visible = true;
                break;

            default:
                break;

        }
    }

    Button{
        id: abContactViewPrevButton
        width: AppStyle.abButtonWidth
        Layout.fillWidth: true
        Layout.preferredWidth: AppStyle.abButtonWidth
        text: "Previous user"

        onClicked: {
            if( currentIndex === undefined){
                currentIndex = 0
            }

            console.log("CurrentIndex goes from: " + Number(currentIndex))
            if( currentIndex <= 0){
                currentIndex = ( abJSONModel.count - 1)
            }else if(  currentIndex > 0 ){
                currentIndex -= 1
            }else{
                console.log("Error in abContactViewPrevButton, illegal value in currentIndex")
            }
            console.log("CurrentIndex  goes  to: " + Number(currentIndex))

                var jsonObject = abStack.jsonABData[currentIndex]
                abContactViewIdField.text = jsonObject["id"]
                abContactViewFirstNameField.text = jsonObject["firstname"]
                abContactViewLastNameField.text = jsonObject["lastname"]
                abContactViewNumberField.text = jsonObject["mobile"]
                abContactViewEmailField.text = jsonObject["email"]

        }
    }

    Button{
        id: abContactViewNextButton
        width: AppStyle.abButtonWidth
        Layout.fillWidth: true
        Layout.preferredWidth: AppStyle.abButtonWidth
        text: "Next user"
        onClicked: {
            if( currentIndex === undefined){
                currentIndex = 0
            }

            console.log("CurrentIndex goes from: " + Number(currentIndex))
            if( ( currentIndex + 1) >= Number(abJSONModel.count ) ){
                currentIndex = 0
            }else if( ( currentIndex + 1 ) < Number(abJSONModel.count) ){
                currentIndex += 1
            }else{
                console.log("Error in abContactViewNextButton, illegal value in currentIndex")
            }
            console.log("CurrentIndex  goes  to: " + Number(currentIndex))
                var jsonObject = abStack.jsonABData[currentIndex]
                abContactViewIdField.text = jsonObject["id"]
                abContactViewFirstNameField.text = jsonObject["firstname"]
                abContactViewLastNameField.text = jsonObject["lastname"]
                abContactViewNumberField.text = jsonObject["mobile"]
                abContactViewEmailField.text = jsonObject["email"]
        }

    }


    Button{
        id: abContactViewSaveButton
        width: AppStyle.abButtonWidth
        Layout.fillWidth: true
        Layout.preferredWidth: AppStyle.abButtonWidth
        Layout.column: 0
        Layout.row: 1
        text: AppStyle.abSaveUser
        onClicked: {
            currentContact = {"id":abContactViewIdField.text,
                "firstname":abContactViewFirstNameField.text,
                "lastname":abContactViewLastNameField.text,
                "mobile":abContactViewNumberField.text,
                "email":abContactViewEmailField.text};
            Utils.sendContactDataToCloud(AppStyle.abURLAddressBook, currentContact)

        }
    }

    Button{
        id: abContactViewEditButton
        width: AppStyle.abButtonWidth
        Layout.fillWidth: true
        Layout.preferredWidth: AppStyle.abButtonWidth
        Layout.column: 0
        Layout.row: 1
        visible: false
        text: "Edit user"
        onClicked: {
            Utils.contactStateTo("UPDATE")
            if(Utils.debugMode) console.log("ABContactButtonView.qml:abContactViewEditButton:onClicked-> Run STATE now:" + abStack.state)


        }
    }

    Button{
        id: abContactViewSearchBackButton
        width: AppStyle.abButtonWidth
        Layout.fillWidth: true
        Layout.preferredWidth: AppStyle.abButtonWidth
        Layout.column: 0
        Layout.row: 1
        visible: false
        text: "Back"
        onClicked: {

        }
    }


    Button{
        id: abContactViewBackToMainButton
        width: AppStyle.abButtonWidth
        Layout.preferredWidth: AppStyle.abButtonWidth
        Layout.fillWidth: true
        Layout.column: 1
        Layout.row: 1
        text: AppStyle.abReturnToMain
        onClicked: {
            //push(abMainView)
            if(Utils.debugMode) console.log("Old State: " + abStack.state);
            Utils.getDataFromLocalDB();
            abStack.state =  "MAIN"
         }
    }



}
