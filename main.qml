import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtQuick.Timeline 1.0
import QtQuick.Window 2.2
import "."


ApplicationWindow {
    id: appWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("QTAndroidTestbench")

    signal changeToAddressBook

    property string combochoicetext1 : "Addressbook"
    property string combochoicetext2 : "Apple"
    property string combochoicetext3 : "Pineapple"

    property var comboChoice : QtObject { property int choice: 0 }


    header: ToolBar {
            height: AppStyle.headerTitleSize

            Label {
                text: qsTr("QtAndroidTestbench Dev state")
               // background: "grey"
               // color: "black"
                font.pixelSize: 10
                anchors.centerIn: parent
            }
        }
    footer: ToolBar{
            height: AppStyle.headerTitleSize

            Label{
                text: qsTr("QtAndroidTestbench Dev state")
                font.pixelSize: 10
                anchors.centerIn: parent
            }
    }


    StackView{
       id: scroll1
       anchors.fill: parent
       //initialItem: Qt.resolvedUrl("")



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
            leftPadding: parent.width * 0.05
            rightPadding: parent.width * 0.05
            currentIndex: 2

            model: [ combochoicetext1 , combochoicetext2 , combochoicetext3 ]

            onCurrentIndexChanged:{
                 // When using loader, preload upcoming view here?
                 // Using currentText always shows previously chosen one.
                 //console.debug("CurrentText says: " + currentText)
                 console.debug("TextAt(currentIndex) says: " + textAt(currentIndex) )

                 // Doesn't get updated after initial setting
                 // update: Works now when using QtObject
                 comboChoice.choice = currentIndex

            }
        }



        Button {
            id: button1
            width: parent /2
            height: 50
            anchors.top: combo1.bottom

            text: "TestButton"
            autoExclusive: true
            //onClicked: {
                    //console.debug("Button says: " + comboChoice.choice)
                //windowLoader.source = "addressbook.qml"
                //goToAddressbook


            }
        }

        /*
        ListView {
            anchors.top: button1.bottom
            width: parent.width
            model: 5
            delegate: ItemDelegate {
                text: "Item " + (index + 1)
                width: parent.width
            }
        }
        */

         Loader {
            id: windowLoader
            anchors.fill: parent


         }

         Connections {
             ignoreUnknownSignals: true
             //target: windowLoader.valid ? windowLoader.item : null
             target: button1
             onClicked : {
                if (comboChoice.choice === 0 ) windowLoader.source = "addressbook.qml"
                else console.debug("Button says: " + comboChoice.choice)
             }
             onChangeToAddressbook: { windowLoader.source = "Addressbook.qml" }
             onExit : { windowLoader.source = "main.qml" }
         }

   }

