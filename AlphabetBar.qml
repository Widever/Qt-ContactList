import QtQuick 2.0
import QtQuick.Layouts 1.15

ColumnLayout{
    visible: !filtered && !onlyFavorites
    Repeater{
        id: alphabetJump
        Rectangle{
            id: letter
            height: parent.width
            width: parent.width
            color: "transparent"
            Text {
                anchors.fill: parent
                text: qsTr(modelData.symbol)
                color: Style.textColor
                font.bold: modelData.available
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    if(!modelData.available) return
                    contactListModel.clear()
                    var countVisibleItems = lv_contactList.height/lv_contactList.delegateHeight+1
                    var letterChunk = contactListProvider.getDataChunk(modelData.firstContactIndex-lv_contactList.chunkSize, countVisibleItems + lv_contactList.chunkSize)
                    contactListModel.append(letterChunk)
                    lv_contactList.positionViewAtIndex(lv_contactList.chunkSize, ListView.Beginning )
                }

                onContainsMouseChanged: {
                    letter.color =  containsMouse ? Style.enteredColor : "transparent"
                }
            }
        }
    }

    Component.onCompleted: {
        var availableLetters = contactListProvider.getAvailableLetters()
        alphabetJump.model = availableLetters
    }
}
