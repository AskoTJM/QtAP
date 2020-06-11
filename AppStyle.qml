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

    // Strings, probably smarter to transfer into another file.
    property string appChoice1Title: "Addressbook"
}
