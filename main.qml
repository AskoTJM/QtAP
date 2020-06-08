import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtQuick.Timeline 1.0

ApplicationWindow {
    id: appWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("QTAndroidTestbench")


   ScrollView {
       id: scroll1
       anchors.fill: parent


        Text {
            anchors.top: parent.top
            font.pointSize: 24
            color: "white"
            textFormat: Text.RichText
            topPadding: parent.height * 0.05
            leftPadding: parent.width * 0.05
            rightPadding: parent.width * 0.05

            //implicitHeight: parent.height * 0.45

            id: descriptionText
            width: parent.width
            height: 120
            wrapMode: Text.WordWrap

            text: qsTr("Qt/Android Testbench")
            font.family: "Arial"
            horizontalAlignment: Text.AlignHCenter

        }

        ComboBox {
            id: combo1
            anchors.top: descriptionText.bottom
            width: parent.width
            model: [ "banana", "Apple", "Testi"]


                /*ListModel {
                id: model
                ListElement { text: "Banana"; color: "Yellow" }
                ListElement { text: "Apple"; color: "Green" }
                ListElement { text: "Coconut"; color: "Brown" }
                */
            //}
            //onAccepted: {
            //    if (find(currentText) === -1) {
            //        model.append({text: editText})
            //        currentIndex = find(editText)
            //    }
            //}
        }

        Button {
            id: button1
            width: parent /2
            height: 50
            anchors.top: combo1.bottom

            text: "TestButton"
            //onClicked:
        }

        ListView {
            anchors.top: button1.bottom
            width: parent.width
            model: 5
            delegate: ItemDelegate {
                text: "Item " + (index + 1)
                width: parent.width
            }
        }
    }
}
