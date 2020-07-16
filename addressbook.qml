import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
//import QtQuick 2.15
import QtQuick.LocalStorage 2.12

import "."
import "littlehelper.js" as Utils
import "addressBookRES"
//import
StackView {

    id: abStack
// Signals
    signal message(string msg)
    signal returnToMain()

//    initialItem: abMainView
    state: "MAIN"
    anchors.fill: parent
    anchors.leftMargin: AppStyle.appLeftMargin
    anchors.rightMargin: AppStyle.appRightMargin

    visible: true

// Maybe use States to change UI and functionality ?
    property var currentState

// Switching between contacts is using Index
    property var currentIndex
// new or updated contact data
    property var currentContact
// Local Temporary Data
    property var jsonABData

    Component.onCompleted: {

    }

    states: [
        State{
            name: "MAIN"

            StateChangeScript{
                name: "mainScript"
                script: {
                    if(Utils.debugMode) console.log("addressbook.qml:mainScript-> Run");
                    abStack.push(abMainView)
                }
            }
        },
        State{
            name: "BROWSE"
            StateChangeScript{
                name: "browseScript"
                script: {
                    target: abStack
                    if(Utils.debugMode) console.log("addressbook.qml:browseScript-> Run");
                    abStack.push(abAddressView)
                }
            }
        },
        State{
            name: "ADD"
            StateChangeScript{
                name: "addScript"
                script: {
                    if(Utils.debugMode) console.log("addressbook.qml:addScript-> Run");
                    abStack.push(abContactView)
                }
            }
        },
        State{
            name: "UPDATE"
        },
        State{
            name: "SEARCH"
        }

    ]

    ListModel{
        id: abJSONModel
    }

        Component{
            id: abAddressList

            MouseArea {

                width:  childrenRect.width
                height: childrenRect.height
                onClicked: {
                   currentIndex = index
                   console.log("Clicked: index: " + index + " id: "+ id +" "+ lastname +", "+ firstname +" ")
                   push(abContactView)
                }
                RowLayout{
                    spacing: 10
                    Text {
                      color: AppStyle.appTextColor
                      font.pixelSize: AppStyle.appDefaultFontSize
                      text: (id).pad(3) + ": "
                      horizontalAlignment: Text.AlignRight

                    }
                    Text {
                      color: AppStyle.appTextColor
                      font.pixelSize: AppStyle.appDefaultFontSize
                      text: lastname +", "

                    }
                    Text {
                      color: AppStyle.appTextColor
                      font.pixelSize: AppStyle.appDefaultFontSize
                      text: firstname


                    }
                }//RowLayout
            }//MouseArea
        }//Component


    Pane{

        ABMainView{
            id: abMainView
        }

        ABAddressView{
            id: abAddressView
        }

        ABContactView{
             id: abContactView
        }

    }
}//StackView

