import QtQuick 2.15

GridView {
    id: grid
    property var cellSize: 90
    clip: true
    snapMode: GridView.SnapToRow
    delegate: ContactGridDelegate{}
    Component.onCompleted: {
        var contactsData = contactListProvider.contactData
        contactListModel.append(contactsData)
    }
}
