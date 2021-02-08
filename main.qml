import QtQuick 2.5
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.15

Rectangle {
    id: root
    color: Style.backgroundColor
    property var onlyFavorites: false
    property var filtered: false
    property var filterText: ""
    property var gridViewMode: false

    ColumnLayout{
        anchors.fill: parent

        OptionsPanel{
            Layout.fillWidth: true
            height: 50
        }

        Loader{
            id: mainLoader
            Layout.fillHeight: true
            Layout.fillWidth: true
            sourceComponent: listView
        }

        Component{
            id: listView
            ContactList{
                id: lv_contactList
                model: contactListModel
            }
        }

        Component{
            id: gridView
            ContactGrid{
                id: gv_contactList
                height: mainLoader.height
                width: mainLoader.width
                model: contactListModel
            }
        }
    }

    ListModel{
        id: contactListModel
    }

    CallPopup{
        id: callPopup
        height: root.height/1.5
        width: root.width/1.5
        anchors.centerIn: parent
    }

    onOnlyFavoritesChanged: {
        if(onlyFavorites){
            contactListModel.clear()
            var onlyFavoritesModel = contactListProvider.getOnlyFavorites()
            contactListModel.append(onlyFavoritesModel)
        }
        else{
            contactListModel.clear()
            if(!filtered){
                var dataChunk
                if(!gridViewMode)
                    dataChunk = contactListProvider.getDataChunk(0, lv_contactList.height/lv_contactList.delegateHeight+lv_contactList.chunkSize)
                else
                    dataChunk = contactListProvider.contactData
                contactListModel.append(dataChunk)
            }
            else{
                var filteredData = contactListProvider.getFilteredData(filterText, onlyFavorites)
                contactListModel.append(filteredData)
            }
        }
        mainLoader.item.positionViewAtBeginning()
    }

    onGridViewModeChanged: {
        if(gridViewMode){
            mainLoader.sourceComponent = gridView
        }
        else{
            mainLoader.sourceComponent = listView
        }
    }
}
