import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtQuick.Timeline 1.0
import QtQuick.Window 2.2
import "."



ApplicationWindow {
    id: appWindow
    visible: true
// Not necessary?
    //   width: 640
    //   height: 480
    title: qsTr("QTAndroidTestbench")
    color: AppStyle.appBackgroundColor

// Signals
    signal changeToAddressBook

// Needed to update comboChoice correctly, otherwise seemed to stuck on first one selected
    property var comboChoice : QtObject { property int choice: 0 }

// Removed, just takes space and currently doesn't provide any function that can excuse the used screen space
//    header: ToolBar {
//            height: AppStyle.headerTitleSize

//            Label {
//                text: qsTr("QtAndroidTestbench Dev mode")
//                font.pixelSize: 15
//                anchors.centerIn: parent
//            }
//        }
//    footer: ToolBar{
//            height: AppStyle.headerTitleSize

//            Label{
//                id: footerTxt
//                text: qsTr("QtAndroidTestbench Dev state")
//                font.pixelSize: 15
//                anchors.centerIn: parent
//            }

//    }



    ScrollView{
       id: scroll1
       anchors.fill: parent
       anchors.leftMargin: AppStyle.appLeftMargin
       anchors.rightMargin: AppStyle.appRightMargin


        Text {
            id: descriptionText
            anchors.top: parent.top
            font.pointSize: 24
            color: AppStyle.appTextColor
            textFormat: Text.RichText
            topPadding: parent.height * 0.05
            leftPadding: parent.width * 0.05
            rightPadding: parent.width * 0.05


            width: parent.width
            height: implicitHeight
            wrapMode: Text.WordWrap

            text: qsTr("Qt/Android Testbench")
            font.family: "Arial"
            horizontalAlignment: Text.AlignHCenter

        }

        Text {
            id: appGuideText
            width: parent.width
            font.pointSize: AppStyle.appInfoFontSize
            color: AppStyle.appTextColor
            textFormat: Text.RichText
            topPadding: parent.height * 0.05
            leftPadding: parent.width * 0.05
            rightPadding: parent.width * 0.05
            anchors.top: descriptionText.bottom
            text: AppStyle.appChoiceDefaultDescription
            wrapMode: Text.WordWrap
            font.family: "Arial"
            horizontalAlignment: Text.AlignHCenter
        }


    // ComboBox for choosing which sub app user wants to try.
        ComboBox {
            id: appChoiceCombo
            anchors {
                top: appGuideText.bottom
                leftMargin: parent.width * 0.05
                rightMargin: parent.width * 0.05
                topMargin:  20
            }
            width: parent.width
            leftPadding: parent.width * 0.05
            rightPadding: parent.width * 0.05

        // Set ComboBox Index to 0 so we have something chosen by default
            currentIndex: 0

            //model: [ combochoicetext1 , combochoicetext2 , combochoicetext3 ]
            model: [ AppStyle.appChoice0Title,
                     AppStyle.appChoice1Title,
                     AppStyle.appChoice2Title]



            onCurrentIndexChanged:{               
                 console.debug("TextAt(currentIndex) says: " + textAt(currentIndex) )
                 comboChoice.choice = currentIndex
            // Stupid way of doing this but couldn't figure out how to create automatically
                switch(currentIndex){
                    case 0:
                        appDescriptionText.text = AppStyle.appChoice0Description
                        break;
                    case 1:
                        appDescriptionText.text = AppStyle.appChoice1Description
                        break;
                    case 2:
                        appDescriptionText.text = AppStyle.appChoice2Description
                        break;
                    default:
                        break;
                    }


            }
        }

        Rectangle{

            id: appDescriptionTextRectangle
            border.width: 2
            anchors.top: appChoiceCombo.bottom
            anchors.topMargin: 6
            anchors.margins: parent.width * 0.05
            width: parent.width * 0.95
            anchors.horizontalCenter: parent.horizontalCenter
            height: 140
            color: "white"       
            visible: true

             Text {

                id: appDescriptionText
                padding: 10
                wrapMode: Text.WordWrap               

                anchors.fill: parent
            // Replace this with script later?
                Component.onCompleted: appDescriptionText.text = AppStyle.appChoice0Description
            }

        }

        Button {
            id: button1
            width: parent /2
            height: 50
            anchors.top: appDescriptionTextRectangle.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Go"
            autoExclusive: true
            onClicked: {
                   switch(comboChoice.choice){
                       case 0:
                        // Header and footer were removed to get more screen estate
//                           footerTxt.text = "Addressbook"
                           windowLoader.source = "addressbook.qml"
                           break;
                       case 1:
                        // Header and footer were removed to get more screen estate
//                           footerTxt.text = "Apples"
                           console.debug("Button says: " + comboChoice.choice)
                           break;
                       default:
                        // Header and footer were removed to get more screen estate
//                           footerTxt.text = comboChoice.choice
                           console.debug("Button says: " + comboChoice.choice)
                           break;
                   }
             }
        }
    }



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
            // Header and footer were removed to get more screen estate
//                 footerTxt.text = "Main"
             }
             //onExit : { windowLoader.source = "main.qml" }
         }

}
