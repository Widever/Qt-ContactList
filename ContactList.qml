import QtQuick 2.0
import QtQuick.Layouts 1.15

ListView{
    id: lv_contactList
    AlphabetBar{
        anchors.margins: Style.mediumOffset
        height: parent.height-10
        width: 15
        anchors.right: parent.right
    }
    section.criteria: ViewSection.FirstCharacter
    section.property: "name"

    property var delegateHeight: 50
    property var chunkSize: 5

    model: contactListModel
    spacing: 1
    clip: true
    delegate: ContactDelegate{}

    onContentYChanged: {
        if(onlyFavorites||filtered) return
        var item = lv_contactList.itemAt(0, lv_contactList.contentY)
        if(item === null) return
        var currIndex = item.absoluteIndex
        var lastIndexInModel = contactListModel.get(contactListModel.count-1).index_
        var firstIndexInModel = contactListModel.get(0).index_
        var dataChunk
        var countVisibleItems = 0
        countVisibleItems = lv_contactList.height / lv_contactList.delegateHeight -1

        //scroll up
        if(currIndex+countVisibleItems>=lastIndexInModel-lv_contactList.chunkSize){
            dataChunk = contactListProvider.getDataChunk(lastIndexInModel+1, chunkSize)
            if(dataChunk.length===0) return
            contactListModel.append(dataChunk)
            for(let i =0;i<firstIndexInModel-currIndex-chunkSize;i++){
                contactListModel.remove(0)
            }
        }

        //scroll down
        if(currIndex<firstIndexInModel+lv_contactList.chunkSize-1){
            dataChunk = contactListProvider.getDataChunk(firstIndexInModel-chunkSize-1, chunkSize)
            if(dataChunk.length===0) return
            for(let i =0;i< dataChunk.length;i++){
                var dataItem = dataChunk[dataChunk.length-1-i]
                contactListModel.insert(0, dataItem)
                contactListModel.remove(contactListModel.count-1)
            }
        }


    }

    Component.onCompleted: {
        var dataChunk = contactListProvider.getDataChunk(0, lv_contactList.chunkSize*3)
        contactListModel.append(dataChunk)
    }
}
