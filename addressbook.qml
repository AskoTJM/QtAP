import QtQuick 2.0
import QtQuick.Controls 2.5
import "."
import "littlehelper.js" as Utils




StackView {

    id: abStack
// Signals
    signal message(string msg)
    signal returnToMain()

    initialItem: abMainView
    anchors.fill: parent

    visible: true

    property alias msg: ttext
    // property will store data
     property var jsonData: null

        Text { id: ttext; anchors.fill: parent; anchors.margins: 10 }

    Component{
        id: abMainView
        // Component can only have one child, so wrapping everything in Item works around that, child->grandchild?
            Item{
                Rectangle{

                    color: AppStyle.appBackgroundColor
                    anchors{
                    // Didn't work as planned, but I might try again later
                        //top: parent.top
                        //left: parent.left
                        //right: parent.right
                        //bottom: parent.bottom
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
                            //left: parent.left
                        }
                    }

                    Grid{
                        width: implicitWidth // parent.width
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
                                //anchors.top: abMainText.bottom
                                width: AppStyle.abButtonWidth

                                text: AppStyle.abGetData
                                onClicked: {
                                    push(abAddressView)
                                }
                            }

                            Button{
                                id: abAddDataButton
                                width: AppStyle.abButtonWidth

                                //anchors.top: abGetDataButton.bottom
                                text: "Add data"
                                onClicked: {
                                    push(abContactView)
                                }
                            }

                            Button{
                                id: abBackToMainButton
                                width: AppStyle.abButtonWidth


                                text: "Back to main"
                                onClicked: abStack.returnToMain()
                            }

                    }
                }
        }
    }

    Component{
            id: abAddressView
        // Component can only have one child, so wrapping everything in Item works around that, grandchildren  > children ?
            Item{
               // Let's try something else,
                Component.onCompleted: getData2()
               // Component.onCompleted: Utils.makeRequest()

                Rectangle{

                color: AppStyle.appBackgroundColor
                anchors{
                // Didn't work as planned, but I might try again later
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    //bottom: addBookBackToMainButton.top
                }

                    Text{

                        id: abAddressViewText
                        color: AppStyle.appTextColor
                        text: "AddressBook"
                        font.pointSize: 27
                        fontSizeMode: Text.FixedSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors{
                            top: parent.top
                            left: parent.left
                        }
                    }

                    Button{
                        id: abAddressViewPrevButton
                        anchors.top: abAddressViewText.bottom
                        text: "Prev"
                        onClicked: {
                            push(abMainView)
                         }
                    }

                }
            }
    }

    Component{
            id: abContactView
        // Component can only have one child, so wrapping everything in Item works around that, grandchildren  > children ?
            Item{
                Rectangle{

                color: AppStyle.appBackgroundColor
                anchors{
                // Didn't work as planned, but I might try again later
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    //bottom: addBookBackToMainButton.top
                }

                    Text{

                        id: abContactViewText
                        color: AppStyle.appTextColor
                        text: "ThirdTest"
                        font.pointSize: 27
                        fontSizeMode: Text.FixedSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors{
                            top: parent.top
                            left: parent.left
                        }
                    }

                    Button{
                        id: abContactViewPrevButton
                        anchors.top: abContactViewText.bottom
                        text: "Prev"
                        onClicked: {
                            push(abMainView)
                         }
                    }

                }
            }
        }



// Were going with the another one.  Keeping this code for now. Cleanup later.
//
//    function getData(){
//       // var url = new URL('https://qtphone.herokuapp.com/contact');
//        console.log("Hmm1")

//        var req = new XMLHttpRequest;
//                req.open("GET", 'https://qtphone.herokuapp.com/contact');
//                console.log("Hmm2")
//        req.onload = function() {
//                console.log("Hmm3")
//                var objectArray = JSON.parse(req.responseText);
//                    if (objectArray.errors !== undefined) {
//                        console.log("Error : " + objectArray.errors[0].message)
//                        console.log("Hmm4")

//                    } else {
//                        for (var key in objectArray.statuses) {
//                            var jsonObject = objectArray.statuses[key];
//                            //tweets.append(jsonObject);
//                            //console.log(jsonObject)
//                            console.log("Hmm5")
//                        }
//                    }
//                    // wrapper.isLoaded()
//                }
//                req.send();
//                console.log("Hmm6")
//    }


    function getData2(){

        console.log("Hmmm1")
        var xhr = new XMLHttpRequest
            console.log("Hmmm2")
            xhr.onreadystatechange = function() {
              if (xhr.readyState === XMLHttpRequest.DONE) {
                console.log("Hmmm3")
            // New test code
                jsonData = xhr.responseText
                var objectArray = JSON.parse(xhr.responseText)
            // chug data to safety
                jsonData = objectArray
                //console.log("Hmmm4 "+ objectArray.email)
                  for (var x in objectArray) {
                      var jsonObject = objectArray[x]
                      //console.log("Very hmm " + x + " " + jsonObject["email"]) // Object.keys(objectArray).length)
                      console.log("Very hmm " + x + " " + jsonData["lastname"])
                  }
                //
                var dataString = xhr.responseText
                //console.log("Hmmm4 "+ dataString)

                abStack.jsonData = JSON.parse(dataString)
              }
            }
            console.log("Hmmm5")
            xhr.open("GET", Qt.resolvedUrl("https://qtphone.herokuapp.com/contact"))
            xhr.send()
            console.log("Hmmm6")
          }


}
