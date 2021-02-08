import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: root
    property var contactName: ""
    modal: true
    padding: 0
    Rectangle{
        anchors.fill: parent
        color: Style.primaryColor
        ColumnLayout{
            anchors.fill: parent
            Item{
                id:image_wrapper
                Layout.fillHeight: true
                Layout.fillWidth: true
                Image {
                    id: call_image
                    anchors.centerIn: parent
                    height: Math.min(root.height, root.width)/2
                    width: call_image.height
                    source: "call_icon.svg"
                }
                RotationAnimation on rotation {
                    loops: Animation.Infinite
                    from: 0
                    to: 10
                    duration: 300
                }

            }
            Text {
                Layout.fillWidth: true
                height: 40
                color: Style.textColor
                text: qsTr("Call to "+root.contactName)
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.bottomMargin: Style.mediumOffset
            }
        }
    }
}
