import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.19 as Kirigami

import org.tulip.Kirigami64 0.2

Kirigami.ScrollablePage {
	id: configureBuildSheet

	title: i18nc("@title:window", "Configure " + Backend.buildList(Backend.buildSelected))

	function updateValues() {
		nameInp.text = Backend.buildConfigSpecificDataGet(Backend.buildSelected, 0);
		descInp.text = Backend.buildConfigSpecificDataGet(Backend.buildSelected, 1);
		iconInp.text = Backend.buildConfigSpecificDataGet(Backend.buildSelected, 2);
		iconValidate.source = iconInp.text;
		romLayout.currentRegion = Backend.buildConfigSpecificDataGet(Backend.buildSelected, 3)*1;
		romComboBox.currentIndex = romLayout.currentRegion;

		console.log("Region is int " + romLayout.currentRegion);
	}

	RowLayout {
		ColumnLayout {
			id: configBuild

			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.maximumWidth: 450.0

			Kirigami.Heading {
				Layout.fillWidth: true
				level: 2
				type: Kirigami.Heading.Type.Primary
				text: "Repository Configuration"
				horizontalAlignment: Text.AlignHCenter
			}

			Kirigami.Separator {
				Layout.fillWidth: true
			}

			Kirigami.Heading {
				Layout.fillWidth: true
				level: 3
				type: Kirigami.Heading.Type.Secondary
				text: "Settings"
				horizontalAlignment: Text.AlignHCenter
			}

			Kirigami.Separator {
				Layout.fillWidth: true
			}

			RowLayout {
				Controls.Label {
					text: "Display Name in launcher:"
				}

				Controls.TextField {
					id: nameInp
					placeholderText: "Name:"
				}
			}

			RowLayout {
				Controls.Label {
					text: "Description in launcher:"
				}

				Controls.TextField {
					id: descInp
					placeholderText: "Description:"
				}
			}

			RowLayout {
				Controls.Label {
					text: "Icon (name or path):"
				}

				Controls.TextField {
					id: iconInp
					onTextEdited: iconValidate.source = iconInp.text
				}

				Kirigami.Icon {
					id: iconValidate
					source: ""
				}
			}

			RowLayout {
				id: romLayout
				property int currentRegion: 0
				Controls.Label {
					text: "ROM Region: "
				}
				
				Controls.ComboBox {
					id: romComboBox
					width: 200
					model: ["Default", "US", "EU", "JP"]

					onCurrentIndexChanged: romLayout.currentRegion = currentIndex
				}
			}

			Kirigami.Heading {
				Layout.fillWidth: true
				level: 3
				type: Kirigami.Heading.Type.Secondary
				text: "Confirm"
				horizontalAlignment: Text.AlignHCenter
			}

			Kirigami.Separator {
				Layout.fillWidth: true
			}

			Controls.Button {
				text: "Set repository configuration"
				onClicked: [Backend.modifyConfig(nameInp.text, descInp.text, iconInp.text, romLayout.currentRegion), showPassiveNotification("Updated config for " + Backend.buildList(Backend.buildSelected) + "."), Backend.buildFind(0)]
			}
		}
	}
}
