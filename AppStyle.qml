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

    property string appChoiceDefaultDescription: "This app was tested in AVD with 5\" display at 1920x1080 resolution. \n WebView in About doesn't play nice with Android 7.0"

    property string appChoice0Title: "Addressbook"
    property string appChoice0Description: "App for accessing addressbook located in Heroku using JSON. \n Summer 2020 project for Oulu University of Applied Sciences.\n"

    property string appChoice1Title: "Apple"
    property string appChoice1Description: "How do you like them apples? \n Nothing here, yet."

    property string appChoice2Title: "Banana"
    property string appChoice2Description: "BANANAS!!! Tank yu."

// addressbook.qml ( = ab) Specifics
    // URLs
    property string abURLAddressBook: "https://qtphone.herokuapp.com/contact"

    // Strings
    property string abGetData: "Browse Contacts"
    property string abAddUser: "Add Contact"
    property string abReturnToMain: "Return to main"
    property string abTitle: "Heroku Addressbook"
    property string abAddressViewDefaultTitle: "Addresses automatically from local DB"
    property string abGetDataFromCloud: "Get from Cloud"
    property string abSaveUser: "Save data"
    property string abSearch: "Search"
    property string abAbout: "About"
    property string abAddressFromCloud: "Addresses from Cloud"
    property string abSaveToLocalDB: "Save To Local DB"
    property string abGetFromLocalDB: "From Local DB"
    property string abAddressFromLocalDB: "Addresses from Local DB"
    property string abPreviousUser: "Previous user"
    property string abNextUser: "Next user"
    property string abEditUser: "Edit user"
    property string abBack: "Back"
    property string abIdText: "id: "
    property string abFirstNameText: "Firstname: "
    property string abLastNameText: "Lastname: "
    property string abPhoneText: "Phone: "
    property string abEmailText: "Email: "

    // Values
    property int abButtonWidth: 150
    property int abButtonMarging: 10
    property int abContactViewSecondColumnSpan : 1
    property var abContactViewSecondColumnWidth : 0.6
    property var abContactViewFirstColumnWidth : 0.25 // 0.09


}

