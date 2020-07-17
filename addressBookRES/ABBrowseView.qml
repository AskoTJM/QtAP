import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12

import "."
import ".."
import "../littlehelper.js" as Utils
Component{
    Item {

        Rectangle{
        id: browseBackground
        color: AppStyle.appBackgroundColor
        anchors.fill: parent

            Item{

                ABBrowseButtonView{
                    id: abBrowseButtons1
                    anchors.top: parent.top
                }

                ABBrowseButtonView{
                    id: abBrowseButtons
                    anchors.top: abBrowseButtons1.bottom
                }

                ABAddressView{
                    id: abAddressView2;

                    //anchors.top: abBrowseButtons.bottom
                }

//                Rectangle{
//                    //anchors.fill: abAddressViewScroll
//                    color: AppStyle.appBackgroundColor
//                    //color: "white"
//                    anchors.top: abBrowseButtons.bottom
//                    anchors.topMargin: 10
//                        //anchors.top: abSqLiteDataCounterText.bottom
//                        //anchors.top: abCounterText.bottom
//                    //anchors.bottom: browseBackground.bottom
//                    width: browseBackground.width
//                    implicitHeight: abAddressListView.contentHeight



//                    ScrollView{
//                        id: abAddressViewScroll
//                        height: parent.height
//                        width: parent.width - 20
//                        //clip: true
//                        //padding: 10

//                        ListView {
//                                id: abAddressListView
//                                anchors.top: parent.top
//                                //Screws up
//                                boundsBehavior: Flickable.StopAtBounds
//                                clip: true
//                                width: parent * 0.95
//                                //height: contentHeight
//                                visible: true
//                                model: abJSONModel
//                                delegate: abAddressList
//                        }
//                    }//ScrollView
//                }//Rectangle



//                ScrollView{
//                    id: abAddressViewScroll
//                    height: abAddressListView.implicitHeight
//                    //height: parent.height
//                    width: browseBackground.width
//                    anchors.top: abBrowseButtons.bottom
//                    //clip: true
//                    //padding: 10

//                    Rectangle{
//                        //anchors.fill: abAddressViewScroll
//                        //color: AppStyle.appBackgroundColor
//                        color: "white"
//                        //anchors.bottom: parent.bottom
//                        //anchors.topMargin: 10
//                            //anchors.top: abSqLiteDataCounterText.bottom
//                            //anchors.top: abCounterText.bottom
//                        //anchors.top: abAddressBrowserButtonGrid.bottom
//                        width:  parent.width
//                        height: abAddressListView.implicitHeight
//                        //height: 200
//                        //implicitHeight: abAddressListView.contentHeight

//                            ListView {
//                                    id: abAddressListView
//                                    //anchors.top: abAddressViewScroll.top
//                                    //Screws up
//                                    boundsBehavior: Flickable.StopAtBounds
//                                    clip: true
//                                    width: parent.width
//                                    //width: parent * 0.95
//                                    height: contentHeight
//                                    visible: true
//                                    model: abJSONModel
//                                    delegate: abAddressList
//                                }
//                    }//ScrollView
//                }//Rectangle

            }
        } // Rectangle
    } // Item
} // Component
