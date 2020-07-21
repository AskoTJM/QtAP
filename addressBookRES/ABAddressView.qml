// AddressView
import QtQuick 2.4
//import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
//import QtQuick 2.15
import QtQuick.LocalStorage 2.12// as Sql

import "."
import ".."
import "../littlehelper.js" as Utils


//Component{
    //    id: abAddressView
    // Component can only have one child, so wrapping everything in Item works around that.

            Item{

                Component.onCompleted: (Utils.debugMode ? console.log("ABAddressView.qml ready") : null);


//                Rectangle{

//                color: AppStyle.appBackgroundColor
//                anchors{
//                // Didn't work as planned, but I might try again later
//                    top: parent.top
//                    left: parent.left
//                    right: parent.right
//                    bottom: parent.bottom
//                }



//    }
                    // Counters for testing purposes for how many contacts there are

//                    Text{
//                        id: abCounterText
//                        anchors.top: abAddressBrowserButtonGrid.bottom
//                        //anchors.right: parent.right
//                        font.pointSize: AppStyle.appDefaultFontSize
//                        color: "white"
//                        width: parent.width
//                        text: "Addressess in database: " + abJSONModel.count
//                    }




//                    Text{
//                        id: abAbDataCounterText
//                        anchors.top: abCounterText.bottom
//                        //anchors.right: parent.right
//                        font.pointSize: AppStyle.appDefaultFontSize
//                        color: "white"
//                        //width: parent.width
//                        text: "Addressess in jsonABData: "
//                        visible: (Utils.debugMode ? true : false)

//                    }

//                // Separate Text element needed because at start jsonABData is undefined
//                // and won't show the text
//                    Text{
//                        id: abAbDataCounterNumberText
//                        anchors.top: abCounterText.bottom
//                        anchors.left: abAbDataCounterText.right
//                        //anchors.right: parent.right
//                        font.pointSize: AppStyle.appDefaultFontSize
//                        color: "white"
//                        //width: parent.width
//                        text: JSON.stringify(jsonABData.length)
//                        visible: (Utils.debugMode ? true : false)

//                    }

//                    Text{
//                        id: abSqLiteDataCounterText
//                        anchors.top: abAbDataCounterText.bottom
//                        //anchors.right: parent.right
//                        font.pointSize: AppStyle.appDefaultFontSize
//                        color: "white"
//                        //width: parent.width
//                        text: "Addresses in SqLite"
//                        visible: (Utils.debugMode ? true : false)

//                    }

//                    Text{
//                        id: abSqLiteDataCounterNumberText
//                        anchors.top: abAbDataCounterText.bottom
//                        anchors.left: abSqLiteDataCounterText.right
//                        //anchors.right: parent.right
//                        font.pointSize: AppStyle.appDefaultFontSize
//                        color: "white"
//                        //width: parent.width
//                        text: Utils.getLocalDBSize();
//                        visible: (Utils.debugMode ? true : false)
//                    }

                    Rectangle{
                        id: abAddressViewBackground
                        anchors.fill: parent
                        color: AppStyle.appBackgroundColor
                            //color: "white"
                            //anchors.bottom: parent.bottom
                            //anchors.topMargin: 10
                            //anchors.top: abSqLiteDataCounterText.bottom
                            //anchors.top: abCounterText.bottom
                            //anchors.top: abAddressBrowserButtonGrid.bottom
                            //anchors.top: parent.top
                        //width: parent.width
                        //implicitHeight: //abAddressListView.contentHeight


                        Text{
                            id: abAddressViewTitleText
                            color: AppStyle.appTextColor
                            text: AppStyle.abTitle
                            font.pointSize: AppStyle.appInfoFontSize + 5
                            fontSizeMode: Text.FixedSize
                            anchors.topMargin: 10
                        }



                        ScrollView{
                            id: abAddressViewScroll
                            height: parent.height - (abAddressBrowserButtonGrid.height + abAddressViewTitleText.height + 20)
                            width: parent.width - 20
                            anchors.top: abAddressViewTitleText.bottom
                            anchors.topMargin: 10

                            ListView {
                                    id: abAddressListView
                                    anchors.top: parent.top
                                    boundsBehavior: Flickable.StopAtBounds
                                    clip: true
                                    width: parent * 0.95
                                    visible: true
                                    model: abJSONModel
                                    delegate: abAddressList

                            }
                        }//ScrollView


//                   }//Rectangle

                        ABBrowseButtonView{
                            id: abAddressBrowserButtonGrid
                            //anchors.topMargin: 10
                        }


            }//Rectangle
        }//Item
//}//Component
