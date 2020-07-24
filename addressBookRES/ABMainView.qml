import QtQuick 2.4
//import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
//import QtQuick 2.15
import QtQuick.LocalStorage 2.12// as Sql
import QtWebView 1.1


import "."
import ".."
import "../littlehelper.js" as Utils

Component{
    id: abMainView

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
                                //push(abAddressView)
                                if(Utils.debugMode) console.log("Old State: " + abStack.state);
                                abStack.state =  "BROWSE"
                            }
                        }

                        Button{
                            id: abAddDataButton
                            width: AppStyle.abButtonWidth
                            text: AppStyle.abAddUser
                            onClicked: {
                                currentIndex = -2
                                //push(abContactView)
                                if(Utils.debugMode) console.log("Old State: " + abStack.state);
                                abStack.state =  "ADD"
                            }
                        }

                        Button{
                            id: abSearchButton
                            width: AppStyle.abButtonWidth
                            text: AppStyle.abSearch
                            onClicked: {
                                if(Utils.debugMode) console.log("Old State: " + abStack.state);
                                abStack.state = "SEARCH"
                            }
                        }

                        Button{
                            id: abAboutButton
                            width: AppStyle.abButtonWidth
                            text: "About"
                            onClicked: {
                                if(Utils.debugMode) console.log("Old State: " + abStack.state);
                                //popup.open()
                                abStack.state = "ABOUT"

                            }

                        }

                        Button{
                            id: abSettingsButton
                            width: AppStyle.abButtonWidth
                            text: "Settings ?"
                            onClicked: {

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

//            Popup {
//                    id: popup
//                    parent: Overlay.overlay
//                    x: Math.round((parent.width - width) / 2)
//                    y: Math.round((parent.height - height) / 2)
//                    width: parent.width - 25
//                    height: parent.height  - 25
//                    scale: 0.1
//                    padding: 0
//                    modal: true
//                    focus: true
//                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

//                    WebView {
//                            id: webView
//                            anchors.fill: parent
//                            url: "https://doc.qt.io/qt-5/qtwebengine-index.html"
//                            //userAgent:"Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36  (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36"
//                        }


//                    WebView {
//                        id: webView
//                        anchors.fill: parent

//                        Component.onCompleted: {

//                           var resource = 'https://doc.qt.io/qt-5/qtwebengine-index.html';

//                            var xhr = new XMLHttpRequest;
//                            xhr.open('GET', resource);
//                            xhr.onreadystatechange = function() {
//                                if (xhr.readyState === XMLHttpRequest.DONE) {
//                                    var response = xhr.responseText;
//                                    webView.loadHtml(response);
//                                }
//                            };
//                            xhr.send();
//                        }
//                    }
//            }

        }//Item
}//Component


