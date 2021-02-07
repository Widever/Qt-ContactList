import QtQuick 2.3
import QtQuick.Layouts 1.15
import QtQuick 2.15
import QtQuick.Shapes 1.15
import QtQuick.Controls 2.15

Rectangle {
    property var counter: 0
    ColumnLayout{
        anchors.fill: parent
        ListView{
            Layout.fillHeight: true
            Layout.fillWidth: true
            id: lv_list
            model: lvModel
            delegate: Rectangle{
                width: lv_list.width
                height: 50
                Text {
                    anchors.fill: parent
                    text: index_
                }
            }
        }
        ListModel{
            id: lvModel
        }

        Rectangle{
            height: 40
            width: 100
            color: "steelblue"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lvModel.insert(0, {"index_": counter})
                    counter++
                }
            }
        }
    }


}
