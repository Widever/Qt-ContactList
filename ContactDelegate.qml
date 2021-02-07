import QtQuick 2.0

Rectangle{
        id: delegateRoot
        height: lv_contactList.delegateHeight
        property var absoluteIndex: index_
        width: lv_contactList.width
        color: Style.primaryVariantColor
        Text {
            anchors.fill: parent
            text: qsTr(contactName)
            font.family: "Lucida Sans"
            font.bold: true
            color: Style.textColor
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Rectangle{
            anchors.leftMargin: 10
            anchors.left: parent.left
            height: delegateRoot.height
            width: delegateRoot.height
            color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
            radius: width*0.5
            Image {
                anchors.fill: parent
                source: "contact_icon.svg"
            }
        }

        StarShape{
            anchors.rightMargin: 25
            anchors.right: parent.right
            height: delegateRoot.height
            width: delegateRoot.height
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
