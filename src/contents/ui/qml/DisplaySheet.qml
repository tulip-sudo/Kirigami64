import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.19 as Kirigami

import org.tulpenkiste.kirigami64

Kirigami.ScrollablePage {
    id: displaySheet
	
	actions: [
		Kirigami.Action {
			id: refreshButton
			icon.name: "view-refresh"
			text: qsTr("Refresh", "Refresh list")
			tooltip: qsTr("Refresh list")
			onTriggered: [Backend.buildFind(0), view.model = Backend.buildCountValue()]
		}
	]

	Connections {
		target: Backend
		onBuildCountModified: {
			view.model = Backend.buildCountValue()
		}
	}

	Kirigami.CardsListView {
		id: view
		model: Backend.buildCountValue()
		delegate: Kirigami.AbstractCard {
			contentItem: Item {
				implicitWidth: delegateLayout.implicitWidth
				implicitHeight: delegateLayout.implicitHeight
				GridLayout {
					id: delegateLayout
					anchors {
						left: parent.left
						top: parent.top
						right: parent.right
					}
					rowSpacing: Kirigami.Units.largeSpacing
					columnSpacing: Kirigami.Units.largeSpacing
					columns: width > Kirigami.Units.gridUnit * 20 ? 4 : 2
					Kirigami.Icon {
                        source: Backend.buildConfigSpecificDataGet(modelData, 2)
						Layout.fillHeight: true
						Layout.maximumHeight: Kirigami.Units.iconSizes.huge
						Layout.preferredWidth: height
					}
					ColumnLayout {
						Kirigami.Heading {
							level: 2
                            text: Backend.buildConfigSpecificDataGet(modelData, 0)
						}
						Kirigami.Separator {
							Layout.fillWidth: true
						}
						Controls.Label {
							Layout.fillWidth: true
							wrapMode: Text.WordWrap
                            text: Backend.buildConfigSpecificDataGet(modelData, 1)
						}
					}
					ColumnLayout {
						Controls.Button{
							text: qsTr("Add To Start Menu")
							//icon.name: "desktop"
							onClicked: [Backend.setBuildSelected(modelData), Backend.addShortcut(Backend.buildList(Backend.buildSelected))]
						}
						Controls.Button {
							text: qsTr("View Repository Options")
							onClicked: [Backend.setBuildSelected(modelData), selectedBuildSheet.updateTitle(), selectedBuildSheet.open()]
						}
					}
				}
			}
		}
	}
}
