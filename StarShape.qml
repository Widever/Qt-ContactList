import QtQuick 2.3
import QtQuick.Layouts 1.15
import QtQuick 2.15
import QtQuick.Shapes 1.15

Rectangle {
    id: starWrapper
    width: 600
    height: 600
    color: "transparent"
    property color starColor: "lightblue"
    Shape {
        id: shape
        width: starWrapper.width
        height: starWrapper.height
        anchors.centerIn: parent
        rotation: -18
        transformOrigin: "Center"
        ShapePath {
            id: star
            strokeColor: starColor
            fillColor: starColor
            fillRule: ShapePath.WindingFill
            strokeWidth: 2
            startX: shape.width*0.9
            startY: shape.width*0.5
            PathLine { x: shape.width*0.5 + shape.width*0.4 * Math.cos(0.8 * 1 * Math.PI); y: shape.width*0.5 + shape.width*0.4 * Math.sin(0.8 * 1 * Math.PI) }
            PathLine { x: shape.width*0.5 + shape.width*0.4 * Math.cos(0.8 * 2 * Math.PI); y: shape.width*0.5 + shape.width*0.4 * Math.sin(0.8 * 2 * Math.PI) }
            PathLine { x: shape.width*0.5 + shape.width*0.4 * Math.cos(0.8 * 3 * Math.PI); y: shape.width*0.5 + shape.width*0.4 * Math.sin(0.8 * 3 * Math.PI) }
            PathLine { x: shape.width*0.5 + shape.width*0.4 * Math.cos(0.8 * 4 * Math.PI); y: shape.width*0.5 + shape.width*0.4 * Math.sin(0.8 * 4 * Math.PI) }
            PathLine { x: shape.width*0.9; y: shape.width*0.5 }
        }
    }
}
