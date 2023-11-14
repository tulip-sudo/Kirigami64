import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.2
import QtQuick.Dialogs
import org.kde.kirigami 2.19 as Kirigami
import org.kde.kirigamiaddons.settings as KirigamiSettings

import org.tulpenkiste.kirigami64

KirigamiSettings.CategorizedSettings {
	id: root

	objectName: "settingsPage"
	actions: [
		KirigamiSettings.SettingAction {
			actionName: "General"
			text: "General"
			icon.name: "settings-configure"
			page: Qt.resolvedUrl("config/General.qml")
		},
		KirigamiSettings.SettingAction {
			actionName: "Launch"
			text: "Launch"
			icon.name: "system-run-symbolic"
			page: Qt.resolvedUrl("config/LaunchOptions.qml")
		},
		KirigamiSettings.SettingAction {
			actionName: "Build"
			text: "Build"
			icon.name: "run-build"
			page: Qt.resolvedUrl("config/BuildOptions.qml")
		},
		KirigamiSettings.SettingAction {
			actionName: "About"
			text: "About"
			icon.name: "help-about"
			page: Qt.resolvedUrl("config/About.qml")
		}
	]
}