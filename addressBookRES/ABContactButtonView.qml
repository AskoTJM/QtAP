import QtQuick 2.4
//import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
//import QtQuick 2.15
import QtQuick.LocalStorage 2.12// as Sql

import "."
import ".."
import "../littlehelper.js" as Utils

Grid{
    anchors.bottom: parent.bottom
    rows: 2
    columns: 2
    anchors.horizontalCenter: parent.horizontalCenter
    width: implicitWidth
    height: implicitHeight
    rowSpacing: AppStyle.abButtonMarging / 2
    columnSpacing: AppStyle.abButtonMarging
    //anchors.margins: 20
    //spacing: 10
    //margins: 10


    Button{
        id: abContactViewPrevButton
        width: AppStyle.abButtonWidth
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
//                            dataToContactView(currentIndex)

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
//                            dataToContactView(currentIndex)
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
        text: AppStyle.abSaveUser
        onClicked: {
            currentContact = {"id":abContactViewIdField.text,
                "firstname":abContactViewFirstNameField.text,
                "lastname":abContactViewLastNameField.text,
                "mobile":abContactViewNumberField.text,
                "email":abContactViewEmailField.text};
            //Utils.updateContactInCloud(AppStyle.abURLAddressBook+"/133", currentContact)
            Utils.sendContactDataToCloud(AppStyle.abURLAddressBook, currentContact)
            //console.log("Save data: " + JSON.stringify(currentContact) )

        }
    }

    Button{
        id: abContactViewBackToMainButton
        width: AppStyle.abButtonWidth
        text: AppStyle.abReturnToMain
        onClicked: {
            //push(abMainView)
            if(Utils.debugMode) console.log("Old State: " + abStack.state);
            abStack.state =  "MAIN"
         }
    }
}
