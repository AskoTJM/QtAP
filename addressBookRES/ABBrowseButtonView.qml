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
    //id: abAddressViewGrid
    width: implicitWidth
    height: implicitHeight
    rows: 3
    columns: 2
    rowSpacing: AppStyle.abButtonMarging / 2
    columnSpacing: AppStyle.abButtonMarging
    anchors{
        //top: abAddressViewTitleText.bottom
        horizontalCenter: parent.horizontalCenter
        topMargin: 20
    }

        Button{
            id: abGetDataFromCloud
            width: AppStyle.abButtonWidth
            text: AppStyle.abGetDataFromCloud
            onClicked: {

                Utils.getDataFromCloud(AppStyle.abURLAddressBook)
            }
        }

//        Button{
//            id: abAddressViewDataOutButton
//            width: AppStyle.abButtonWidth
//            text: "Clear jsonABData"
//            onClicked: {
//                Utils.clearABData();

//            }

//        }

        Button{
            id: abAddressViewPlaceholderButton
            width: AppStyle.abButtonWidth
            text: "Save In Local DB"
            onClicked: {
                Utils.clearLocalDB();
                Utils.saveDataToLocalDB();

            }
        }

        Button{
            id: abAddressViewPrevButton
            width: AppStyle.abButtonWidth
            text: AppStyle.abReturnToMain
            onClicked: push(abMainView)
        }

        Button{
            id: abAddressViewTestButton1
            width: AppStyle.abButtonWidth
            text: "Get data from SqLite"
            onClicked: {

                Utils.getDataFromLocalDB()
                //console.log("getDataFromLocalDB: " + JSON.stringify(abStack.jsonABData));
            }
        }

//        Button{
//            id: abAddressViewTestButton2
//            width: AppStyle.abButtonWidth
//            text: "Clear ListView"
//            onClicked: {
//                Utils.clearAddressListView();
//            }
//        }
}
