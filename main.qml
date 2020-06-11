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

    property string combochoicetext1 : AppStyle.appChoice1Title
    property string combochoicetext2 : "Apple"
    property string combochoicetext3 : "Pineapple"

    property var comboChoice : QtObject { property int choice: 0 }


    header: ToolBar {
            height: AppStyle.headerTitleSize

            Label {
                text: qsTr("QtAndroidTestbench Dev mode")
                font.pixelSize: 15
                anchors.centerIn: parent
            }
        }
    footer: ToolBar{
            height: AppStyle.headerTitleSize

            Label{
                id: footerTxt
                text: qsTr("QtAndroidTestbench Dev state")
                font.pixelSize: 15
                anchors.centerIn: parent
            }
    }


    StackView{
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
            currentIndex: 0

            model: [ combochoicetext1 , combochoicetext2 , combochoicetext3 ]

            onCurrentIndexChanged:{               
                 console.debug("TextAt(currentIndex) says: " + textAt(currentIndex) )
                 comboChoice.choice = currentIndex

            }
        }


        Button {
            id: button1
            width: parent /2
            height: 50
            anchors.top: combo1.bottom

            text: "Go"
            autoExclusive: true
            onClicked: {
                   if (comboChoice.choice === 0 ){
                       footerTxt.text = "Addressbook"
                       windowLoader.source = "addressbook.qml"
                   }
                   else{
                       footerTxt.text = comboChoice.choice
                       console.debug("Button says: " + comboChoice.choice)
                   }
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
             target :  windowLoader.item
             onMessage: console.log(msg)
             // target with check is, probably smart but now freezes the whole thing. So don't uncomment
             //target: windowLoader.valid ? windowLoader.item : null


             onReturnToMain: {
                 windowLoader.source = ""
                 footerTxt.text = "Main"
             }
             //onExit : { windowLoader.source = "main.qml" }
         }

   }

}
