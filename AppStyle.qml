import QtQuick 2.0
pragma Singleton

QtObject {
// Object sizes
    property int appHeaderTitleSize: 10

// Font sizes
    property int appHeaderFontSize : 15

// Colors
    property color appHeaderBackgroundColor: "black"
    property color appBackgroundColor: "black"
    property color appTextColor: "white"

// Strings for ComboBox choosing app, probably would be smarter to transfer into another file.

    property string appChoiceDefaultDescription: "This app was tested with 5\" display at 1920x1080 resolution \nand targeting Android API 24 (Android 7.0) \nSo if it looks weird, try those."

    property string appChoice0Title: "Addressbook"
    property string appChoice0Description: "App for accessing addressbook located in Heroku using JSON"

    property string appChoice1Title: "Apple"
    property string appChoice1Description: "How do you like them apples?"

    property string appChoice2Title: "Banana"
    property string appChoice2Description: "BANANAS!!!"

}

