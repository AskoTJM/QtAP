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
    //    id: abAddressView
    // Component can only have one child, so wrapping everything in Item works around that.


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
                        rows: 3
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

                                    Utils.getDataFromCloud(AppStyle.abURLAddressBook)
                                }
                            }

                            Button{
                                id: abAddressViewDataOutButton
                                width: AppStyle.abButtonWidth
                                text: "Clear jsonABData"
                                onClicked: {
                                    Utils.clearABData();

                                }

                            }

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

                            Button{
                                id: abAddressViewTestButton2
                                width: AppStyle.abButtonWidth
                                text: "Clear ListView"
                                onClicked: {
                                    Utils.clearAddressListView();
                                }
                            }
                    }


                    // Counters for testing purposes for how many contacts there are
                    Text{
                        id: abCounterText
                        anchors.top: abAddressViewGrid.bottom
                        //anchors.right: parent.right
                        font.pointSize: AppStyle.appDefaultFontSize
                        color: "white"
                        width: parent.width
                        text: "Addressess in database: " + abJSONModel.count
                    }

                    Text{
                        id: abAbDataCounterText
                        anchors.top: abCounterText.bottom
                        //anchors.right: parent.right
                        font.pointSize: AppStyle.appDefaultFontSize
                        color: "white"
                        //width: parent.width
                        text: "Addressess in jsonABData: "

                    }

                // Separate Text element needed because at start jsonABData is undefined
                // and won't show the text
                    Text{
                        id: abAbDataCounterNumberText
                        anchors.top: abCounterText.bottom
                        anchors.left: abAbDataCounterText.right
                        //anchors.right: parent.right
                        font.pointSize: AppStyle.appDefaultFontSize
                        color: "white"
                        //width: parent.width
                        text: JSON.stringify(jsonABData.length)

                    }

                    Text{
                        id: abSqLiteDataCounterText
                        anchors.top: abAbDataCounterText.bottom
                        //anchors.right: parent.right
                        font.pointSize: AppStyle.appDefaultFontSize
                        color: "white"
                        //width: parent.width
                        text: "Addresses in SqLite"

                    }

                    Text{
                        id: abSqLiteDataCounterNumberText
                        anchors.top: abAbDataCounterText.bottom
                        anchors.left: abSqLiteDataCounterText.right
                        //anchors.right: parent.right
                        font.pointSize: AppStyle.appDefaultFontSize
                        color: "white"
                        //width: parent.width
                        text: Utils.getLocalDBSize();
                    }

                    Rectangle{
                        //anchors.fill: abAddressViewScroll
                        color: AppStyle.appBackgroundColor
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 10
                        anchors.top: abSqLiteDataCounterText.bottom
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
