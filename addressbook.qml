import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12

import "."
import "littlehelper.js" as Utils
import "addressBookRES"
//import
StackView{

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

// Switching between contacts is using Index
    property var currentIndex
// new or updated contact data
    property var currentContact
// Local Temporary Data
    property var jsonABData

    Component.onCompleted: {      
        if(Utils.debugMode) console.log(this.height + " and " + this.width);
        Utils.getDataFromLocalDB();
    }

    states: [
        State{
            name: "MAIN"
            StateChangeScript{
                name: "mainScript"
                script: {
                    //target: abStack
                    if(Utils.verboseMode) console.log("addressbook.qml:STATE:MAIN-> Run");
                    // Some bug(?) popped up and requires now this to function.
                    abStack.clear();
                    abStack.push(abMainView);
                }
            }
        },
        State{
            name: "BROWSE"
            StateChangeScript{
                name: "browseScript"
                script: {
                    //target: abStack
                    if(Utils.verboseMode) console.log("addressbook.qml:STATE:BROWSE-> Run");

                    abStack.push(abAddressView)
                    //abStack.push(abBrowseState)
                }
            }
        },
        State{
            name: "ADD"
            StateChangeScript{
                name: "addScript"
                script: {
                    if(Utils.verboseMode) console.log("addressbook.qml:STATE:ADD-> Run");
                    abStack.push(abContactView)
                }
            }
        },
        State{
            name: "UPDATE"
            StateChangeScript{
                name: "updateScript"
                script: {
                    if(Utils.verboseMode) console.log("addressbook.qml:STATE:UPDATE-> Run");
                }
            }
        },
        State{
            name: "VIEW"
            StateChangeScript{
                name: "viewScript"
                script: {
                    if(Utils.verboseMode) console.log("addressbook.qml:STATE:VIEW-> Run");
                    abStack.push(abContactView)
                }
            }
        },

        State{
            name: "SEARCH"
            StateChangeScript{
                name: "searchScript"
                script: {
                    if(Utils.verboseMode) console.log("addressbook.qml:STATE:SEARCH-> Run");
                    abStack.push(abContactView)
                }
            }
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
               if(Utils.debugMode) console.log("addressbook.qml:abAddressList-> Current STATE: "+ abStack.state)
               currentIndex = index
               if(Utils.debugMode) console.log("Clicked: index: " + index + " id: "+ id +" "+ lastname +", "+ firstname +" ")
               push(abContactView)
               abStack.state = "VIEW"

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

                Text {
                  color: AppStyle.appTextColor
                  font.pixelSize: AppStyle.appDefaultFontSize
                  text: mobile
                  visible: false

                }

                Text {
                  color: AppStyle.appTextColor
                  font.pixelSize: AppStyle.appDefaultFontSize
                  text: email
                  visible: false
                }


            }//RowLayout
            }//MouseArea
    }//Component

    Component{
        id: abContactSearchEmailList

        MouseArea {

            width:  childrenRect.width
            height: childrenRect.height
            onClicked: {
               if(Utils.debugMode) console.log("addressbook.qml:abAddressList-> Current STATE: "+ abStack.state)
               currentIndex = index
               if(Utils.debugMode) console.log("Clicked: index: " + index + " id: "+ id +" "+ lastname +", "+ firstname +" ")
               push(abContactView)
               abStack.state = "VIEW"

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
                  visible: false
                }

                Text {
                  color: AppStyle.appTextColor
                  font.pixelSize: AppStyle.appDefaultFontSize
                  text: mobile
                  visible: false

                }

                Text {
                  color: AppStyle.appTextColor
                  font.pixelSize: AppStyle.appDefaultFontSize
                  text: email
                  visible: true
                }


            }//RowLayout
            }//MouseArea
    }//Component

    Component{
        id: abContactSearchMobileList

        MouseArea {

            width:  childrenRect.width
            height: childrenRect.height
            onClicked: {
               if(Utils.debugMode) console.log("addressbook.qml:abAddressList-> Current STATE: "+ abStack.state)
               currentIndex = index
               if(Utils.debugMode) console.log("Clicked: index: " + index + " id: "+ id +" "+ lastname +", "+ firstname +" ")
               push(abContactView)
               abStack.state = "VIEW"

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
                  text: lastname

                }

                Text {
                  color: AppStyle.appTextColor
                  font.pixelSize: AppStyle.appDefaultFontSize
                  text: ", "
                  visible: false

                }

                Text {
                  color: AppStyle.appTextColor
                  font.pixelSize: AppStyle.appDefaultFontSize
                  text: firstname
                  visible: false
                }

                Text {
                  color: AppStyle.appTextColor
                  font.pixelSize: AppStyle.appDefaultFontSize
                  text: mobile
                  visible: true

                }

                Text {
                  color: AppStyle.appTextColor
                  font.pixelSize: AppStyle.appDefaultFontSize
                  text: email
                  visible: false
                }


            }//RowLayout
            }//MouseArea
    }//Component

    Pane{

        // Main
        ABMainView{
            id: abMainView
        }

        // Browsing addressbook
        ABAddressView{
            id: abAddressView
        }

        // Add new contact
        ABContactView{
             id: abContactView
        }

        ABBrowseView{
            id: abBrowseState
        }

    }
}//StackView

