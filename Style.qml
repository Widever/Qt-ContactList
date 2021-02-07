pragma Singleton
import QtQuick 2.0
QtObject {
    readonly property color primaryColor: "#444444"
    readonly property color primaryVariantColor: "#747474"
    readonly property color backgroundColor: "#282120"
    readonly property color selectColor: "gold"
    readonly property color unselectColor: "#B1B1B1"

    readonly property color errorColor: "#B00020"
    readonly property color textColor: "#F8EFE4"
    readonly property color themeDefaultColor: "#FFFFFF"
    readonly property color themeInvertedColor: "#000000"

    readonly property real defaultOpacity: 1
    readonly property real emphasisOpacity: 0.87
    readonly property real secondaryOpacity: 0.6
    readonly property real disabledOpacity: 0.38

    readonly property int defaultOffset: 15
    readonly property int mediumOffset: 10
    readonly property int tinyOffset: 5

    readonly property int bigSpacing: 20
    readonly property int mediumSpacing: 10
    readonly property int smallSpacing: 7
}
