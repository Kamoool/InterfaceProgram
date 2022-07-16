import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:qs_ds_app/model/constants_repository.dart';
import 'package:qs_ds_app/model/serial_port_utils.dart';
import 'package:qs_ds_app/model/settings_repository.dart';
import 'package:qs_ds_app/widgets/v2_widgets/widgets.dart' as ver2;

class VersionParser {
  bool isSupported = ConstantsRepository()
      .supportedVersions
      .any((element) => element.contains(SettingsRepository().majorVersion.value));

  List<SpeedDialChild> getActionButtons(BuildContext context) {
    List<SpeedDialChild> buttons = [];

    if (isSupported) {
      buttons.add(SpeedDialChild(
        child: const Icon(Icons.get_app),
        label: "Read",
        labelStyle: const TextStyle(fontSize: 20),
        labelBackgroundColor: Colors.yellow,
        backgroundColor: Colors.yellow,
        onTap: () {
          SerialPortUtils().readData();
        },
      ));
      buttons.add(SpeedDialChild(
        child: const Icon(Icons.save),
        label: "Save",
        labelStyle: const TextStyle(fontSize: 20),
        labelBackgroundColor: Colors.green,
        backgroundColor: Colors.green,
        onTap: () {
          SerialPortUtils().saveSettings();
        },
      ));
      buttons.add(SpeedDialChild(
        child: const Icon(Icons.restart_alt),
        label: "Reset",
        labelStyle: const TextStyle(fontSize: 20),
        labelBackgroundColor: Colors.blue,
        backgroundColor: Colors.blue,
        onTap: () {
          SerialPortUtils().resetSettings();
        },
      ));
    }
    buttons.add(SpeedDialChild(
      child: const Icon(Icons.exit_to_app),
      label: "Disconnect",
      labelStyle: const TextStyle(fontSize: 20),
      labelBackgroundColor: Colors.red,
      backgroundColor: Colors.red,
      onTap: () {
        SerialPortUtils().disconnect();
        Navigator.pop(context);
      },
    ));

    if (isSupported) {
      if (SettingsRepository().systemUnlocked) {
        buttons.add(SpeedDialChild(
          child: const Icon(Icons.get_app),
          label: "Read system",
          labelStyle: const TextStyle(fontSize: 20),
          labelBackgroundColor: Colors.cyanAccent,
          backgroundColor: Colors.cyanAccent,
          onTap: () {
            SerialPortUtils().readSystemData();
          },
        ));
        buttons.add(SpeedDialChild(
          child: const Icon(Icons.save),
          label: "Save system",
          labelStyle: const TextStyle(fontSize: 20),
          labelBackgroundColor: Colors.cyanAccent,
          backgroundColor: Colors.cyanAccent,
          onTap: () {
            SerialPortUtils().saveSystemSettings();
          },
        ));
        buttons.add(SpeedDialChild(
          child: const Icon(Icons.restart_alt),
          label: "Reset system",
          labelStyle: const TextStyle(fontSize: 20),
          labelBackgroundColor: Colors.cyanAccent,
          backgroundColor: Colors.cyanAccent,
          onTap: () {
            SerialPortUtils().resetSystemSettings();
          },
        ));
        buttons.add(SpeedDialChild(
          child: const Icon(Icons.close),
          label: "Lock system",
          labelStyle: const TextStyle(fontSize: 20),
          labelBackgroundColor: Colors.cyanAccent,
          backgroundColor: Colors.cyanAccent,
          onTap: () {
            SerialPortUtils().lockSession();
          },
        ));
      }
    }

    return buttons;
  }

  Widget getSensorsWidget() {
    if (SettingsRepository().majorVersion.value == '2') {
      return ver2.SensorWidget();
    }
    return const SizedBox();
  }

  Widget getTabContent(String text, Function() refresh) {
    if (SettingsRepository().majorVersion.value == '2') {
      if (text == 'General') {
        return ver2.GeneralWidget(notifyParent: refresh);
      }
      if (text == 'Quickshifter') {
        return ver2.QuickshifterWidget(
          notifyParent: refresh,
        );
      }
      if (text == 'Downshifter') {
        return ver2.DownshifterWidget(
          notifyParent: refresh,
        );
      }
      if (text == 'System') {
        return ver2.SystemWidget(
          notifyParent: refresh,
        );
      }
    }
    return Center(
      child: Text(
        'Unsupported module version! Your module version is ${SettingsRepository().majorVersion.value}.${SettingsRepository().minorVersion.value}',
        style: const TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
  }
}
