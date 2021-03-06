import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import Qt.labs.settings 1.0

import OpenHD 1.0

BaseWidget {
    id: pressTempWidget
    width: 30
    height:30

    visible: settings.show_press_temp

    widgetIdentifier: "press_temp_widget"

    defaultAlignment: 1
    defaultXOffset: 12
    defaultYOffset: 32
    defaultHCenter: false
    defaultVCenter: false

    hasWidgetDetail: true
    widgetDetailComponent: Column {
        Item {
            width: parent.width
            height: 32
            Text {
                id: opacityTitle
                text: qsTr("Transparency")
                color: "white"
                height: parent.height
                font.bold: true
                font.pixelSize: detailPanelFontPixels
                anchors.left: parent.left
                verticalAlignment: Text.AlignVCenter
            }
            Slider {
                id: press_temp_opacity_Slider
                orientation: Qt.Horizontal
                from: .1
                value: settings.press_temp_opacity
                to: 1
                stepSize: .1
                height: parent.height
                anchors.rightMargin: 0
                anchors.right: parent.right
                width: parent.width - 96

                onValueChanged: {
                    settings.press_temp_opacity = press_temp_opacity_Slider.value
                }
            }
        }
        Item {
            width: parent.width
            height: 32
            Text {
                text: qsTr("Size")
                color: "white"
                height: parent.height
                font.bold: true
                font.pixelSize: detailPanelFontPixels
                anchors.left: parent.left
                verticalAlignment: Text.AlignVCenter
            }
            Slider {
                id: press_temp_size_Slider
                orientation: Qt.Horizontal
                from: .5
                value: settings.press_temp_size
                to: 3
                stepSize: .1
                height: parent.height
                anchors.rightMargin: 0
                anchors.right: parent.right
                width: parent.width - 96

                onValueChanged: {
                    settings.press_temp_size = press_temp_size_Slider.value
                }
            }
        }
    }

    Item {
        id: widgetInner

        anchors.fill: parent
        scale: settings.press_temp_size

        Text {
            id: temp_glyph
            color: OpenHD.press_temp >= 65 ? (OpenHD.press_temp >= 75 ? "#ff0000" : "#fbfd15") : settings.color_shape
            opacity: settings.press_temp_opacity
            text: OpenHD.press_temp >= 65 ? (OpenHD.press_temp >= 75 ? "\uf2c7" : "\uf2c9") : "\uf2cb"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            font.family: "Font Awesome 5 Free"
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 16
            verticalAlignment: Text.AlignTop
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
            style: Text.Outline
            styleColor: settings.color_glow
        }

        Text {
            id: press_temp
            color: OpenHD.press_temp >= 65 ? (OpenHD.press_temp >= 75 ? "#ff0000" : "#fbfd15") : settings.color_text
            opacity: settings.press_temp_opacity
            text: OpenHD.press_temp == 0 ? qsTr("N/A") : OpenHD.press_temp + "°"
            anchors.left: temp_glyph.right
            anchors.leftMargin: 2
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignRight
            font.pixelSize: 14
            font.family: settings.font_text
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
            style: Text.Outline
            styleColor: settings.color_glow
        }       
    }
}
