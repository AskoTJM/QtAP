// Button Grid for Browsing

import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12

import "."
import ".."
import "../littlehelper.js" as Utils

Grid{
// id: abAddressViewGrid
anchors.bottom: parent.bottom
rows: 2
columns: 2
anchors.horizontalCenter: parent.horizontalCenter
width: implicitWidth
height: implicitHeight
rowSpacing: AppStyle.abButtonMarging / 2
columnSpacing: AppStyle.abButtonMarging


        Button{
            id: abGetDataFromCloud
            width: AppStyle.abButtonWidth
            text: AppStyle.abGetDataFromCloud
            onClicked: {
                Utils.getDataFromCloud(AppStyle.abURLAddressBook)
                abAddressViewTitleText.text = AppStyle.abAddressFromCloud
            }
        }


        Button{
            id: abAddressViewPlaceholderButton
            width: AppStyle.abButtonWidth
            text: AppStyle.abSaveToLocalDB
            onClicked: {
                Utils.clearLocalDB();
                Utils.saveDataToLocalDB();

            }
        }


        Button{
            id: abAddressViewGetLocalDB
            width: AppStyle.abButtonWidth
            text: AppStyle.abGetFromLocalDB
            onClicked: {              
                Utils.getDataFromLocalDB()
                abAddressViewTitleText.text = AppStyle.abAddressFromLocalDB

            }
        }

        Button{
            id: abBrowseViewBackToMainButton
            width: AppStyle.abButtonWidth
            text: AppStyle.abReturnToMain
            onClicked: {
                if(Utils.debugMode) console.log("Old State: " + abStack.state);
                abStack.state =  "MAIN"
             }
        }

}



