import QtQuick 2.5
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.15

Rectangle {
    color: "lightsteelblue"
    property var onlyFavorites: false
    property var filtered: false

    ColumnLayout{
        anchors.fill: parent

        Rectangle{
            id: settingsPanel
            Layout.fillWidth: true
            height: 50
            color: "lightsteelblue"
            border.color: "grey"
            border.width: 2
            RowLayout{
                anchors.fill: parent

                TextField{
                    id: tf_filter
                    //Layout.fillHeight: true
                    width: 100
                    Layout.leftMargin: 10
                    font.pixelSize: 18
                    placeholderText: qsTr("Search")
                    onTextChanged: {
                        if(tf_filter.text===""){
                            filtered = false
                        }
                        else{
                            filtered = true
                        }

                        contactListModel.clear()
                        console.log(tf_filter.text)
                        var filteredModel = contactListProvider.getFilteredData(tf_filter.text)
                        contactListModel.append(filteredModel)

                    }
                }
                Rectangle{
                    height: settingsPanel.height -10
                    width: settingsPanel.height -10
                    Layout.alignment: Qt.AlignRight
                    Layout.margins: 5
                    color: onlyFavorites ? "gold" : "lightgrey"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            onlyFavorites = !onlyFavorites
                        }
                    }
                }
            }
        }

        ListView{
            id: lv_contactList
            Layout.fillHeight: true
            Layout.fillWidth: true
            ColumnLayout{
                anchors.margins: 10
                height: parent.height-10
                width: 15
                anchors.right: parent.right
                Repeater{
                    id: alphabetJump
                    Rectangle{
                        height: parent.width
                        width: parent.width
                        color: "transparent"
                        Text {
                            anchors.fill: parent
                            text: qsTr(modelData.symbol)
                            font.bold: modelData.available
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                contactListModel.clear()
                                //lv_contactList.positionViewAtBeginning()
                                var countVisibleItems = lv_contactList.height/lv_contactList.delegateHeight
                                console.log(modelData.firstContactIndex)
                                var letterChunk = contactListProvider.getDataChunk(modelData.firstContactIndex-lv_contactList.chunkSize, countVisibleItems + lv_contactList.chunkSize)
                                contactListModel.append(letterChunk)
                                if(letterChunk.length===countVisibleItems + lv_contactList.chunkSize)
                                    lv_contactList.positionViewAtIndex(lv_contactList.chunkSize, ListView.Beginning )
                            }
                        }
                    }
                }
            }

            property var delegateHeight: 50
            property var chunkSize: 5

            model: contactListModel
            spacing: 5
            clip: true
            delegate: Rectangle{
                id: delegateRoot
                height: lv_contactList.delegateHeight
                property var absoluteIndex: index_
                width: lv_contactList.width
                //visible: !onlyFavorites ? true : favorite
                color: "lightgreen"
                Text {
                    anchors.fill: parent
                    text: qsTr(contactName)
                    font.family: "Lucida Sans"
                    font.bold: true

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Rectangle{
                    anchors.leftMargin: 10
                    anchors.left: parent.left
                    height: delegateRoot.height
                    width: delegateRoot.height
                    color: "lightblue"
                    radius: width*0.5
                    Image {
                        anchors.fill: parent
                        source: "contact_icon.png"
                    }
                }

                StarShape{
                    anchors.rightMargin: 25
                    anchors.right: parent.right
                    height: delegateRoot.height
                    width: delegateRoot.height
                    starColor: favorite ? "gold" : "white"
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
            ListModel{
                id: contactListModel
            }

            onContentYChanged: {
                if(onlyFavorites||filtered) return
                //console.log("ttrr")
                var item = lv_contactList.itemAt(0, lv_contactList.contentY)
                if(item === null) return
                var currIndex = item.absoluteIndex
                var lastIndexInModel = contactListModel.get(contactListModel.count-1).index_
                var firstIndexInModel = contactListModel.get(0).index_
                console.log(currIndex)
                var dataChunk
                var countVisibleItems = 0
                countVisibleItems = lv_contactList.height / lv_contactList.delegateHeight -1

                //scroll up
                if(currIndex+countVisibleItems>=lastIndexInModel-lv_contactList.chunkSize){
                    console.log("up")
                    dataChunk = contactListProvider.getDataChunk(lastIndexInModel+1, chunkSize)
                    if(dataChunk.length===0) return
                    contactListModel.append(dataChunk)
                    for(let i =0;i<firstIndexInModel-currIndex-chunkSize;i++){
                        contactListModel.remove(0)
                    }
                }

                //scroll down
                if(currIndex<firstIndexInModel+lv_contactList.chunkSize-1){
                    console.log("down")
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
                var availableLetters = contactListProvider.getAvailableLetters()
                alphabetJump.model = availableLetters
            }
        }
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