import QtQuick 2.10
import QtQuick.Controls 2.3
import QtWebView 1.1
import "."
import ".."
import "../littlehelper.js" as Utils
//import QtWebKit 3.0

Item {
    anchors.fill: parent

//    WebView {
//            id: webView
//            anchors.fill: parent
//            url: "qrc:/notes.html"
//        }

    WebView {
        id: webView
        anchors.fill: parent

        Component.onCompleted: {

           var resource = 'https://doc.qt.io/qt-5/qtwebengine-index.html';

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
        onClicked: ;
    }
}
