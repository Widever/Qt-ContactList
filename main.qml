import QtQuick 2.5
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.15

Rectangle {
    color: Style.backgroundColor
    property var onlyFavorites: false
    property var filtered: false

    ColumnLayout{
        anchors.fill: parent

        OptionsPanel{
            Layout.fillWidth: true
            height: 50
        }

        ContactList{
            id: lv_contactList
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: contactListModel
        }
    }

    ListModel{
        id: contactListModel
    }

    onOnlyFavoritesChanged: {
        if(onlyFavorites){
            contactListModel.clear()
            var onlyFavoritesModel = contactListProvider.getOnlyFavorites()
            contactListModel.append(onlyFavoritesModel)
        }
        else{
            contactListModel.clear()
            var dataChunk = contactListProvider.getDataChunk(0, lv_contactList.height/lv_contactList.delegateHeight+lv_contactList.chunkSize)
            contactListModel.append(dataChunk)
        }
        lv_contactList.positionViewAtBeginning()
    }
}
