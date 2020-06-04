import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtQuick.Timeline 1.0

ApplicationWindow {
    visible: true
    //width: 640
    //height: 480
    title: qsTr("QTAndroidTestbench")

    ScrollView {
        anchors.fill: parent

        Text {
            font.pointSize: 24
            color: "white"
            textFormat: Text.RichText
            topPadding: parent.height * 0.05
            leftPadding: parent.width * 0.05
            rightPadding: parent.width * 0.05

            //implicitHeight: parent.height * 0.45

            id: descriptionText
            width: parent.width
            height: 120
            wrapMode: Text.WordWrap

            text: qsTr("Text Here.")
            font.family: "Arial"
            horizontalAlignment: Text.AlignHCenter

        }

        ListView {
            anchors.top: descriptionText.bottom
            width: parent.width
            model: 5
            delegate: ItemDelegate {
                text: "Item " + (index + 1)
                width: parent.width
            }
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                loops: 1
                running: true
                to: 1000
                from: 0
                duration: 1000
            }
        ]
        enabled: true
        endFrame: 1000
        startFrame: 0
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
