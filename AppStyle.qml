import QtQuick 2.0
pragma Singleton




QtObject {

// Object sizes
    property int appHeaderTitleSize: 10
    property int appLeftMargin: 20
    property int appRightMargin: 20

// Font sizes
    property int appHeaderFontSize : 15
    property int appInfoFontSize: 15
    property int appDefaultFontSize: 20
    property int appDefaultButtonFontSize: 20

// Colors
    property color appHeaderBackgroundColor: "black"
    property color appBackgroundColor: "black"
    property color appTextColor: "whitesmoke"

//  main.qml Specifics

    // Strings for ComboBox choosing app, probably would be smarter to transfer into another file.

    property string appChoiceDefaultDescription: "This app was tested with 5\" display at 1920x1080 resolution \nand targeting Android API 24 (Android 7.0) \nSo if it looks weird, try those."

    property string appChoice0Title: "Addressbook"
    property string appChoice0Description: "App for accessing addressbook located in Heroku using JSON \n HOX! Asking permission for local storage is not implemented yet. Allow manually from settings->apps->QtAP."

    property string appChoice1Title: "Apple"
    property string appChoice1Description: "How do you like them apples?"

    property string appChoice2Title: "Banana"
    property string appChoice2Description: "BANANAS!!!"

// addressbook.qml ( = ab) Specifics
    // URLs
    property string abURLAddressBook: "https://qtphone.herokuapp.com/contact"

    // Strings
    property string abGetData: "Browse Contacts"
    property string abAddUser: "Add Contact"
    property string abReturnToMain: "Return to main"
    property string abTitle: "Heroku Addressbook"
    property string abGetDataFromCloud: "Get from Cloud"
    property string abSaveUser: "Save data"
    property string abSearch: "Search"

    // Values
    property int abButtonWidth: 150
    property int abButtonMarging: 10
    property int abContactViewSecondColumnSpan : 1
    property var abContactViewSecondColumnWidth : 0.6
    property var abContactViewFirstColumnWidth : 0.25 // 0.09


}

