import QtQuick 2.0
import QtQuick.Layouts 1.15

ColumnLayout{
    Repeater{
        id: alphabetJump
        Rectangle{
            height: parent.width
            width: parent.width
            color: "transparent"
            Text {
                anchors.fill: parent
                text: qsTr(modelData.symbol)
                color: Style.textColor
                font.bold: modelData.available
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    contactListModel.clear()
                    var countVisibleItems = lv_contactList.height/lv_contactList.delegateHeight
                    var letterChunk = contactListProvider.getDataChunk(modelData.firstContactIndex-lv_contactList.chunkSize, countVisibleItems + lv_contactList.chunkSize)
                    contactListModel.append(letterChunk)
                    if(letterChunk.length===countVisibleItems + lv_contactList.chunkSize)
                        lv_contactList.positionViewAtIndex(lv_contactList.chunkSize, ListView.Beginning )
                }
            }
        }
    }

    Component.onCompleted: {
        var availableLetters = contactListProvider.getAvailableLetters()
        alphabetJump.model = availableLetters
    }
}
