import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.5
//import Style 1.0

Rectangle{
    id: optionsPanel
    color: Style.primaryColor
    RowLayout{
        anchors.fill: parent

        TextField{
            id: tf_filter
            width: 100
            Layout.leftMargin: Style.mediumOffset
            font.pixelSize: 18
            placeholderText: qsTr("Search")
            onTextChanged: {
                if(tf_filter.text===""){
                    filtered = false
                }
                else{
                    filtered = true
                }
                filterText = tf_filter.text
                contactListModel.clear()
                var filteredModel = contactListProvider.getFilteredData(tf_filter.text, onlyFavorites)
                contactListModel.append(filteredModel)
            }
        }


        RowLayout{
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.rightMargin: Style.mediumOffset
            spacing: Style.smallSpacing

            Rectangle{
                height: optionsPanel.height -10
                width: optionsPanel.height -10
                color: "transparent"
                border.color: Style.borderColor
                border.width: 1

                Image {
                    id: modeImage
                    anchors.fill: parent
                    anchors.margins: Style.tinyOffset
                    source: "list_icon.svg"
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(gridViewMode){
                            gridViewMode = false
                            modeImage.source = "list_icon.svg"
                        }
                        else{
                            gridViewMode = true
                            modeImage.source = "grid_icon.svg"
                        }
                    }
                }

            }

            Rectangle{
                height: optionsPanel.height -10
                width: optionsPanel.height -10
                color: "transparent"
                border.color: Style.borderColor
                border.width: 1
                StarShape{
                    anchors.fill: parent
                    starColor: onlyFavorites ? Style.selectColor : Style.unselectColor
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        onlyFavorites = !onlyFavorites
                    }
                }
            }
        }
    }
}
