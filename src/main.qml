import QtQuick 2.14;
import QtQuick.Layouts 1.14;
import Qt.labs.platform 1.1;
import QtQuick.Controls 2.14;
import Rust 1.0;

ApplicationWindow {
    title: 'Rust';
    width: 640;
    height: 480;
    visible: true;

    MessageDialog {
        id: aboutDialog;
        title: 'About';
    }

    MenuActions {
        id: menuActions;
        onAboutDialog: {
            aboutDialog.text = message;
            aboutDialog.open();
        }
    }

    menuBar: MenuBar {
        Menu {
            title: "Help";
            MenuItem {
                text: "About";
                onTriggered: menuActions.about();
            }
        }
    }

    Greeter {
        id: greeter;
    }

    ColumnLayout {
        anchors.centerIn: parent;

        Label {
            anchors.horizontalCenter: parent.horizontalCenter;
            text: greeter.text;
        }

        Button {
            text: "Hello";
            onClicked: greeter.hello();
        }
    }
}
