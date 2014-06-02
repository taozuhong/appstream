import QtQuick 2.2
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.1
import org.asexample 1.0

ApplicationWindow {
    title: qsTr("QAppStream Example")
    width: 640
    height: 480
    id: mainWindow
    visible: true

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Load Components")

                function loadItems() {
                    var qcomp = Qt.createComponent("ComponentPanel.qml");
                    if (qcomp.status == Component.Ready) {
                        var cpts = asintf.allComponents;

                        var maxNumber = cpts.length;
                        if (cpts.length > 100)
                            maxNumber = 100;

                        for (var i = 0; i < maxNumber; ++i) {
                            var cpt = cpts[i];
                            var cptPanel = qcomp.createObject(mainColumn);
                            cptPanel.parent = mainColumn;
                            cptPanel.name = cpt.name
                            cptPanel.iconUrl = cpt.iconUrl;
                            cptPanel.visible = true;
                        }
                    }
                }

                onTriggered: loadItems();
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    AsIntf {
        id: asintf
    }

    MessageDialog {
        id: simpleMessageDialog
        title: "Meep"
        text: ""
        Component.onCompleted: visible = false
    }

    ScrollView {
        anchors.fill: parent

        Column {
            id: mainColumn
            width: mainWindow.width - 20
            spacing: 4
            anchors.margins: 8
            add: Transition {
                NumberAnimation {
                    properties: "opacity"
                    easing.type: Easing.OutBounce
                    from: 0
                    to: 1
                    duration: 500
                }
            }
        }
    }
}
