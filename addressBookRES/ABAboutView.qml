import QtQuick 2.10
import QtQuick.Controls 2.3
import QtWebView 1.1
//import QtWebKit.experimental 1.0
import "."
import ".."
import "../littlehelper.js" as Utils
//import QtWebKit 3.0

Component{
    Item {

        Rectangle{
            color: AppStyle.appBackgroundColor
            anchors{
                fill: parent
            }

            WebView {
                    id: webView
                    anchors.top: parent.top
                    width: parent.width

                    height: parent.height - (abBackToMainButton.height + 10)

                    //url: "https://stackoverflow.com/questions/14047576/how-to-display-embedded-html-in-qt-webview"

                    // Workaround from https://stackoverflow.com/questions/14047576/how-to-display-embedded-html-in-qt-webview
                    Component.onCompleted: {

                                var resource = 'qrc:/notes.html';

                                var xhr = new XMLHttpRequest;
                                xhr.open('GET', resource);
                                xhr.onreadystatechange = function() {
                                    if (xhr.readyState === XMLHttpRequest.DONE) {
                                        var response = xhr.responseText;
                                        webView.loadHtml(response);
                                    }
                                };
                                xhr.send();
                            }
            }

                Button{
                    id: abBackToMainButton
                    width: AppStyle.abButtonWidth
                    text: AppStyle.abReturnToMain
                    anchors.top: webView.bottom
                    onClicked:{
                        //abStack.returnToMain();
                        abStack.state = "MAIN"
                        abStack.pop();
                    }
                }

        }

//    Component.onCompleted: {
//        webView.url = "https://doc.qt.io/qt-5/qtwebengine-index.html"
//    }
//        WebView {
//                id: webView
//                anchors.fill: parent
//               // url: "https://doc.qt.io/qt-5/qtwebengine-index.html"
//                scale: 0.01
//                //userAgent:"Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36  (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36"
//            }







//    Popup {
//            id: popup
//            x: 100
//            y: 100
//            width: 200
//            height: 300
//            modal: true
//            focus: true
//            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

//            WebView {
//                id: webView
//                anchors.fill: parent

//                Component.onCompleted: {

//                   var resource = 'https://doc.qt.io/qt-5/qtwebengine-index.html';

//                    var xhr = new XMLHttpRequest;
//                    xhr.open('GET', resource);
//                    xhr.onreadystatechange = function() {
//                        if (xhr.readyState === XMLHttpRequest.DONE) {
//                            var response = xhr.responseText;
//                            webView.loadHtml(response);
//                        }
//                    };
//                    xhr.send();
//                }
//            }
//    }

    }
}
