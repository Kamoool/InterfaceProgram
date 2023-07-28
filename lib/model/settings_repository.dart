import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qs_ds_app/model/setting.dart';
import 'package:qs_ds_app/widgets/version_parser.dart';

class SettingsRepository {
  static SettingsRepository? instance;
  late final List<Setting> settingsList;
  late final List<Setting> systemSettingsList;
  late final List<Setting> readingsList;

  final Setting rpm = Setting(SettingType.RPM, '0');
  final Setting sensorReading = Setting(SettingType.Sensor, '2000');
  final Setting majorVersion = Setting(SettingType.MajorVersion, '0');
  final Setting minorVersion = Setting(SettingType.MinorVersion, '0');
  final Setting qsType = Setting(SettingType.QSType, '0');
  final Setting dsType = Setting(SettingType.DSType, '0');
  final Setting qsEnable = Setting(SettingType.QSEnable, '0');
  final Setting dsEnable = Setting(SettingType.DSEnable, '0');
  final Setting pushCheckQS = Setting(SettingType.PushCheckQS, '1');
  final Setting pulses = Setting(SettingType.Pulses, '2');
  final Setting preDelayQS = Setting(SettingType.PreDelayQS, '5');
  final Setting cutTime1 = Setting(SettingType.CutTime1, '70');
  final Setting cutTime2 = Setting(SettingType.CutTime2, '70');
  final Setting cutTime3 = Setting(SettingType.CutTime3, '70');
  final Setting cutTime4 = Setting(SettingType.CutTime4, '70');
  final Setting cutTime5 = Setting(SettingType.CutTime5, '70');
  final Setting cutTime6 = Setting(SettingType.CutTime6, '70');
  final Setting cutTime7 = Setting(SettingType.CutTime7, '70');
  final Setting cutTime8 = Setting(SettingType.CutTime8, '70');
  final Setting qsForce = Setting(SettingType.QSForce, '100');
  final Setting minRPMQS = Setting(SettingType.MinRPMQS, '4000');
  final Setting preDelayDS = Setting(SettingType.PreDelayDS, '5');
  final Setting blipTime1 = Setting(SettingType.BlipTime1, '80');
  final Setting blipTime2 = Setting(SettingType.BlipTime2, '80');
  final Setting blipTime3 = Setting(SettingType.BlipTime3, '80');
  final Setting blipTime4 = Setting(SettingType.BlipTime4, '80');
  final Setting blipTime5 = Setting(SettingType.BlipTime5, '80');
  final Setting blipTime6 = Setting(SettingType.BlipTime6, '80');
  final Setting blipTime7 = Setting(SettingType.BlipTime7, '80');
  final Setting blipTime8 = Setting(SettingType.BlipTime8, '80');
  final Setting dsForce = Setting(SettingType.DSForce, '100');
  final Setting minRPMDS = Setting(SettingType.MinRPMDS, '4000');
  final Setting maxRPMDS = Setting(SettingType.MaxRPMDS, '10000');
  final Setting postDelayQS = Setting(SettingType.PostDelayQS, '500');
  final Setting postDelayDS = Setting(SettingType.PostDelayDS, '500');
  final Setting unlockPassword = Setting(SettingType.UnlockPassword, '0');
  final Setting averageReadingsSensor = Setting(SettingType.AverageReadingsSensor, '1');
  final Setting sensorAllowedChange = Setting(SettingType.SensorAllowedChange, '500');
  final Setting sensorAboveAdjust = Setting(SettingType.SensorAboveAdjust, '2072');
  final Setting sensorBelowAdjust = Setting(SettingType.SensorBelowAdjust, '2024');
  final Setting averageRPM = Setting(SettingType.AverageRPM, '1');
  final Setting dacAdjustmentValue = Setting(SettingType.DACAdjustmentValue, '2');
  final Setting readingDAC = Setting(SettingType.ReadingDAC, '10000');
  final Setting readingDACConnected = Setting(SettingType.ReadingDACConnected, '50000');

  final Tab generalTab = const Tab(text: 'General');
  final Tab qsTab = const Tab(text: 'Quickshifter');
  final Tab dsTab = const Tab(text: 'Downshifter');
  final Tab systemTab = const Tab(text: 'System');
  final Tab wrongVersionTab = const Tab(text: 'Wrong version');

  bool systemUnlocked = false;

  late List<String> lastData;
  late List<String> lastSystemData;

  factory SettingsRepository({bool? newSettings}) {
    if (newSettings == true || instance == null) {
      instance = SettingsRepository.internal();
    }
    return instance!;
  }

  SettingsRepository.internal() {
    settingsList = [
      majorVersion,
      minorVersion,
      qsType,
      dsType,
      qsEnable,
      dsEnable,
      pushCheckQS,
      pulses,
      preDelayQS,
      cutTime1,
      cutTime2,
      cutTime3,
      cutTime4,
      cutTime5,
      cutTime6,
      cutTime7,
      cutTime8,
      qsForce,
      minRPMQS,
      preDelayDS,
      blipTime1,
      blipTime2,
      blipTime3,
      blipTime4,
      blipTime5,
      blipTime6,
      blipTime7,
      blipTime8,
      dsForce,
      minRPMDS,
      maxRPMDS,
      postDelayQS,
      postDelayDS
    ];
    systemSettingsList = [
      averageReadingsSensor,
      sensorAllowedChange,
      sensorAboveAdjust,
      sensorBelowAdjust,
      averageRPM,
      dacAdjustmentValue,
      readingDAC,
      readingDACConnected
    ];
    readingsList = [rpm, sensorReading];
    lastData = [];
    lastSystemData = [];

    for (Setting element in settingsList) {
      lastData.add(element.value);
    }
    for (Setting element in systemSettingsList) {
      lastSystemData.add(element.value);
    }
  }

  void parseValues(String string) {
    List<String> values = string.split(',');
    int charOccurrence = 0;
    for (var value in values) {
      if (RegExp(r'[A-Za-z]').hasMatch(value)) {
        charOccurrence++;
      }
    }
    if (!(charOccurrence > 1)) {
      if (values[0] == 'A') {
        EasyLoading.showSuccess('Settings saved', duration: const Duration(milliseconds: 1000));
      } else if (values[0] == 'B') {
        EasyLoading.showSuccess('Settings reset', duration: const Duration(milliseconds: 1000));
      } else if (values[0] == 'K' && values.length <= systemSettingsList.length + 1) {
        systemUnlocked = true;
        lastSystemData = values.sublist(1);
        for (int i = 1; i < values.length; i++) {
          systemSettingsList[i - 1].value = values[i];
        }
      } else if (values[0] == 'L') {
        EasyLoading.showError('Wrong master password!',
            duration: const Duration(milliseconds: 1000));
      } else if (values[0] == 'M') {
        EasyLoading.showError('Wrong settings!', duration: const Duration(milliseconds: 1000));
      } else if (values[0] == 'T' && values.length <= settingsList.length + 1) {
        lastData = values.sublist(1);
        for (int i = 1; i < values.length; i++) {
          settingsList[i - 1].value = values[i];
        }
      } else if (values[0] == 'V' && values.length <= readingsList.length + 1) {
        for (int i = 1; i < values.length; i++) {
          readingsList[i - 1].value = values[i];
        }
      }
    }
  }

  String generateSaveSettings() {
    String result = '';
    for (int i = 4; i < lastData.length; i++) {
      result += '${settingsList[i].value},';
    }
    result = result.substring(0, result.length - 1);
    return result;
  }

  String generateSaveSystemSettings() {
    String result = '';
    for (int i = 0; i < lastSystemData.length; i++) {
      result += '${systemSettingsList[i].value},';
    }
    result = result.substring(0, result.length - 1);
    return result;
  }

  List<Tab> getTabs() {
    List<Tab> tabs = <Tab>[];

    if (VersionParser().isSupported) {
      if (qsType.value != '0' || dsType.value != '0' || systemUnlocked) {
        tabs.add(generalTab);
        if (qsType.value != '0') {
          tabs.add(qsTab);
        }
        if (dsType.value != '0') {
          tabs.add(dsTab);
        }
        if (systemUnlocked) {
          tabs.add(systemTab);
        }
      }
    } else {
      tabs.add(wrongVersionTab);
    }

    return tabs;
  }
}
