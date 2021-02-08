import QtQuick 2.0
import QtQuick.Layouts 1.15

Rectangle {
    id: delegateRoot
    color: Style.primaryVariantColor
    width: gv_contactList.cellSize
    height: gv_contactList.cellSize
    radius: delegateRoot.height/4.5

    ColumnLayout{
        anchors.fill: parent
        Rectangle{
            id:image_wrapper
            height: delegateRoot.height-40
            width: delegateRoot.height-40
            Layout.alignment: Qt.AlignHCenter
            color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
            radius: width*0.5
            Image {
                id: contact_image
                anchors.centerIn: parent
                height: image_wrapper.height
                width: image_wrapper.height
                source: "contact_icon.svg"
            }
        }
        RowLayout{
            Layout.fillWidth: true
            height: 40
            Text {
                color: Style.textColor
                text: qsTr(contactName)
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.leftMargin: Style.tinyOffset
            }
            StarShape{
                Layout.rightMargin: Style.tinyOffset
                Layout.alignment: Qt.AlignRight
                height: 30
                width: 30
                starColor: favorite ? Style.selectColor : Style.unselectColor
                MouseArea{
                    anchors.fill: parent
                    onClicked: {

                        if(favorite){
                            contactListModel.setProperty(index, "favorite", false)
                            contactListProvider.setContactFavorite(index_, false)
                        }

                        else{
                            contactListModel.setProperty(index, "favorite", true)
                            contactListProvider.setContactFavorite(index_, true)
                        }
                    }
                }
            }

        }
    }
}
