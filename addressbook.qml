import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "."
import "littlehelper.js" as Utils



StackView {


    id: abStack
// Signals
    signal message(string msg)
    signal returnToMain()

    initialItem: abMainView
    anchors.fill: parent
    anchors.leftMargin: AppStyle.appLeftMargin
    anchors.rightMargin: AppStyle.appRightMargin

    visible: true

//    property alias abIdField: abContactViewIdField.text
//    property alias abFirstNameField: abContactViewFirstNameField.text
//    property alias abLastNameField: abContactViewLastNameField.text
//    property alias abNumberField: abContactViewNumberField.text
//    property alias abEmailField: abContactViewEmailField.text

    property var currentIndex
    // property will store data
    property var jsonData



//    function dataToContactView(index){
//        var jsonObject = abStack.jsonData[index]
//        abIdField = jsonObject["id"]
//        abFirstNameField = jsonObject["firstname"]
//        abLastNameField = jsonObject["lastname"]
//        abNumberField = jsonObject["mobile"]
//        abEmailField = jsonObject["email"]
//    }

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
                        rows: 2
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
                                    push(abAddressView)
                                }
                            }

                            Button{
                                id: abAddDataButton
                                width: AppStyle.abButtonWidth
                                text: AppStyle.abAddUser
                                onClicked: {
                                    currentIndex = -2
                                    push(abContactView)
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
        }//Item
    }//Component

    Component{
            id: abAddressView
        // Component can only have one child, so wrapping everything in Item works around that.


                Item{

                    Component.onCompleted: console.log("abAddressView ready") //Utils.getDataFromCloud("https://qtphone.herokuapp.com/contact")

                    Rectangle{

                    color: AppStyle.appBackgroundColor
                    anchors{
                    // Didn't work as planned, but I might try again later
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }

                        Text{

                            id: abAddressViewTitleText
                            color: AppStyle.appTextColor
                            text: AppStyle.abTitle
                            font.pointSize: AppStyle.appInfoFontSize
                            fontSizeMode: Text.FixedSize

                            anchors{
                                top: parent.top
                                margins: AppStyle.abButtonMarging + 10
                                horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Grid{
                            id: abAddressViewGrid
                            width: implicitWidth
                            height: implicitHeight
                            rows: 2
                            columns: 2
                            rowSpacing: AppStyle.abButtonMarging / 2
                            columnSpacing: AppStyle.abButtonMarging
                            anchors{
                                top: abAddressViewTitleText.bottom
                                horizontalCenter: parent.horizontalCenter
                                topMargin: 20
                            }

                                Button{
                                    id: abGetDataFromCloud
                                    width: AppStyle.abButtonWidth
                                    text: AppStyle.abGetDataFromCloud
                                    onClicked: {
                                        Utils.getDataFromCloud("https://qtphone.herokuapp.com/contact")
                                    }
                                }

                                Button{
                                    id: abAddressViewDataOutButton
                                    width: AppStyle.abButtonWidth
                                    text: "CheckIDTest"
                                    onClicked: {
                                    //Testing search function
                                        Utils.searchFromJSON(Dalai, "firstname", false)
                                    }

                                }

                                Button{
                                    id: abAddressViewPlaceholderButton
                                    width: AppStyle.abButtonWidth
                                    text: "Placeholder"
                                    onClicked: console.log("Nope.")
                                }

                                Button{
                                    id: abAddressViewPrevButton
                                    width: AppStyle.abButtonWidth
                                    text: AppStyle.abReturnToMain
                                    onClicked: push(abMainView)
                                }
                        }


                        // Just counter for testing purposes for how many contacts there are
                        Text{
                            id: abCounterText
                            anchors.top: abAddressViewGrid.bottom
                            //anchors.right: parent.right
                            font.pointSize: AppStyle.appDefaultFontSize
                            color: "white"
                            width: parent.width
                            text: "Addressess in database: " + abJSONModel.count
                        }


                        Rectangle{
                            //anchors.fill: abAddressViewScroll
                            color: "grey"
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 10
                            anchors.top: abCounterText.bottom
                            width: parent.width
                            //implicitHeight: abAddressListView.contentHeight



                            ScrollView{
                                id: abAddressViewScroll
                                height: parent.height
                                width: parent.width - 20
                                //clip: true
                                //padding: 10




                                ListView {
                                        id: abAddressListView
                                        anchors.top: parent.top
                                        //Screws up
                                        boundsBehavior: Flickable.StopAtBounds
                                        clip: true
                                        width: parent * 0.95
                                        //height: contentHeight
                                        visible: true
                                        model: abJSONModel
                                        delegate: abAddressList
                                }
                            }//ScrollView
                        }//Rectangle

                }//Rectangle
            }//Item
    }//Component

    Component{
            id: abContactView

        // Component can only have one child, so wrapping everything in Item works around that.
            Item{
                Component.onCompleted: {
                    if(currentIndex >= 0){
                        var jsonObject = abStack.jsonData[currentIndex]
                        abContactViewIdField.text = jsonObject["id"]
                        abContactViewFirstNameField.text = jsonObject["firstname"]
                        abContactViewLastNameField.text = jsonObject["lastname"]
                        abContactViewNumberField.text = jsonObject["mobile"]
                        abContactViewEmailField.text = jsonObject["email"]
                    }else if(currentIndex === -2){
                        abContactViewIdField.clear()
                        abContactViewFirstNameField.clear()
                        abContactViewLastNameField.clear()
                        abContactViewNumberField.clear()
                        abContactViewEmailField.clear()
                    }else if(Number(abJSONModel.count) === 0){
                        Utils.getDataFromCloud("https://qtphone.herokuapp.com/contact")
                        currentIndex = 0
                    }

                }
                Rectangle{
                color: AppStyle.appBackgroundColor
                anchors.fill: parent
                    Text{
                        id: abContactViewTitle
                        text: "Add/Update Contact"
                        color: "white"
                        font.pointSize: 27
                        anchors{
                            top: parent.top
                            topMargin: 30
                            //
                            horizontalCenter: parent.horizontalCenter
                        }
                    }

                    GridLayout{
                        id: abContactGridView
                        rows: 6
                        columns: 2

                        width: parent.width
                        anchors{
                            //fill: parent
                            top: abContactViewTitle.bottom
                            topMargin: 40
                        }



                        Text{

                            id: abContactViewIdText
                            color: AppStyle.appTextColor
                            text: "id: "
                            font.pointSize: AppStyle.appDefaultFontSize
                            Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewFirstColumnWidth


                        }
//                        Rectangle{
//                            color: "white"

                            TextField{
                                id: abContactViewIdField
                                color: AppStyle.appTextColor



                            }
//                        }



                        Text{

                            id: abContactViewFirstNameText
                            color: AppStyle.appTextColor
                            text: "Firstname: "
                            Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewFirstColumnWidth
                            Layout.row: 1
//                            Layout.column: 0
                            font.pointSize: AppStyle.appDefaultFontSize


                        }
                        // Background for text removed for now, didn't behave nicely.
//                        Rectangle{
//                            color: "whitesmoke"
//                            width: abContactViewFirstNameField.width + 10
//                            height: abContactViewFirstNameField.height
//                            radius: 5

                            TextField{
                                id: abContactViewFirstNameField
                                Layout.columnSpan: AppStyle.abContactViewSecondColumnSpan
                                Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewSecondColumnWidth
                                color: AppStyle.appTextColor
                                focus: true

                                //background: "whitesmoke"
                                //Layout.alignment: right
                            }
//                        }

                        Text{

                            id: abContactViewLastNameText
                            color: AppStyle.appTextColor
                            text: "Lastname: "
                            Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewFirstColumnWidth
                            Layout.row: 2
                            font.pointSize: AppStyle.appDefaultFontSize

                        }
                        TextField{
                            id: abContactViewLastNameField
                            color: AppStyle.appTextColor
                            Layout.columnSpan: AppStyle.abContactViewSecondColumnSpan
                            Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewSecondColumnWidth
                        }

                        Text{

                            id: abContactViewNumberText
                            color: AppStyle.appTextColor
                            text: "Phone: "
                            Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewFirstColumnWidth
                            Layout.row: 3
                            font.pointSize: AppStyle.appDefaultFontSize


                        }
                        TextField{
                            id: abContactViewNumberField
                            color: AppStyle.appTextColor
                            Layout.columnSpan: AppStyle.abContactViewSecondColumnSpan
                            Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewSecondColumnWidth
                        }
                        Text{

                            id: abContactViewEmailText
                            color: AppStyle.appTextColor
                            text: "Email: "
                            Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewFirstColumnWidth
                            Layout.row: 4
                            font.pointSize: AppStyle.appDefaultFontSize

                        }
                        TextField{
                            id: abContactViewEmailField
                            color: AppStyle.appTextColor
                            Layout.columnSpan: AppStyle.abContactViewSecondColumnSpan
                            Layout.preferredWidth: abContactGridView.width * AppStyle.abContactViewSecondColumnWidth
                        }



                    } //GridLayout

                Grid{
                    anchors.bottom: parent.bottom
                    rows: 2
                    columns: 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: implicitWidth
                    height: implicitHeight
                    rowSpacing: AppStyle.abButtonMarging / 2
                    columnSpacing: AppStyle.abButtonMarging
                    //anchors.margins: 20
                    //spacing: 10
                    //margins: 10


                    Button{
                        id: abContactViewPrevButton
                        width: AppStyle.abButtonWidth
                        text: "Previous user"
                        onClicked: {
                            if( currentIndex === undefined){
                                currentIndex = 0
                            }

                            console.log("CurrentIndex goes from: " + Number(currentIndex))
                            if( currentIndex <= 0){
                                currentIndex = ( abJSONModel.count - 1)
                            }else if(  currentIndex > 0 ){
                                currentIndex -= 1
                            }else{
                                console.log("Error in abContactViewPrevButton, illegal value in currentIndex")
                            }
                            console.log("CurrentIndex  goes  to: " + Number(currentIndex))
//                            dataToContactView(currentIndex)

                                var jsonObject = abStack.jsonData[currentIndex]
                                abContactViewIdField.text = jsonObject["id"]
                                abContactViewFirstNameField.text = jsonObject["firstname"]
                                abContactViewLastNameField.text = jsonObject["lastname"]
                                abContactViewNumberField.text = jsonObject["mobile"]
                                abContactViewEmailField.text = jsonObject["email"]

                        }
                    }

                    Button{
                        id: abContactViewNextButton
                        width: AppStyle.abButtonWidth
                        text: "Next user"
                        onClicked: {
                            if( currentIndex === undefined){
                                currentIndex = 0
                            }

                            console.log("CurrentIndex goes from: " + Number(currentIndex))
                            if( ( currentIndex + 1) >= Number(abJSONModel.count ) ){
                                currentIndex = 0
                            }else if( ( currentIndex + 1 ) < Number(abJSONModel.count) ){
                                currentIndex += 1
                            }else{
                                console.log("Error in abContactViewNextButton, illegal value in currentIndex")
                            }
                            console.log("CurrentIndex  goes  to: " + Number(currentIndex))
//                            dataToContactView(currentIndex)
                                var jsonObject = abStack.jsonData[currentIndex]
                                abContactViewIdField.text = jsonObject["id"]
                                abContactViewFirstNameField.text = jsonObject["firstname"]
                                abContactViewLastNameField.text = jsonObject["lastname"]
                                abContactViewNumberField.text = jsonObject["mobile"]
                                abContactViewEmailField.text = jsonObject["email"]
                        }

                    }


                    Button{
                        id: abContactViewSaveButton
                        width: AppStyle.abButtonWidth
                        text: AppStyle.abSaveUser
                        onClicked: {
                            console.log("Save data not yet implemented.")
                        }
                    }

                    Button{
                        id: abContactViewBackToMainButton
                        width: AppStyle.abButtonWidth
                        text: AppStyle.abReturnToMain
                        onClicked: {
                            push(abMainView)
                         }
                    }
                }

                }//Rectangle
            }//Item
    }//Component
}//StackView

