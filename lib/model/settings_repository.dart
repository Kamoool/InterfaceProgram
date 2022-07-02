import 'package:flutter/material.dart';
import '../model/setting.dart';

class SettingsRepository {
  static SettingsRepository? instance;
  late final List<Setting> settingsList;
  late final List<Setting> readingsList;

  //General tab pulses numeric
  final double pulsesNumericMin = 0.5;
  final double pulsesNumericMax = 10;
  final double pulsesNumericStep = 0.5;

  //QS cut times numerics
  final double qsCutNumericMin = 30;
  final double qsCutNumericMax = 150;
  final double qsCutNumericStep = 1;

  //Sensor threshold numerics
  final double sensorNumericMin = 1;
  final double sensorNumericMax = 2000;
  final double sensorNumericStep = 1;

  //MinRPM numerics
  final double minRPMNumericMin = 0;
  final double minRPMNumericMax = 15500;
  final double minRPMNumericStep = 100;

  //MaxRPM numerics
  final double maxRPMNumericMin = 500;
  final double maxRPMNumericMax = 16000;
  final double maxRPMNumericStep = 100;

  //PreDelay numerics
  final double preDelayNumericMin = 0;
  final double preDelayNumericMax = 100;
  final double preDelayNumericStep = 1;

  //PostDelay numerics
  final double postDelayNumericMin = 300;
  final double postDelayNumericMax = 10000;
  final double postDelayNumericStep = 10;

  //DS blip times numerics
  final double dsBlipNumericMin = 30;
  final double dsBlipNumericMax = 300;
  final double dsBlipNumericStep = 1;

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

    readingsList = [rpm, sensorReading];
  }

  void parseValues(String string) {
    List<String> values = string.split(',');
    if (values[0] == 'V' && values.length == readingsList.length + 1) {
      for (int i = 1; i < values.length; i++) {
        readingsList[i - 1].value = values[i];
      }
    } else if (values[0] == 'T' && values.length == settingsList.length + 1) {
      for (int i = 1; i < values.length; i++) {
        settingsList[i - 1].value = values[i];
      }
    }
  }

  String generateSaveSettings() {
    String result = 'S,';
    for (int i = 4; i < settingsList.length; i++) {
      result += '${settingsList[i].value},';
    }
    result = result.substring(0, result.length - 1);
    return result;
  }

  List<Tab> getTabs() {
    List<Tab> tabs = <Tab>[];
    if (qsType.value != '0' || dsType.value != '0') {
      tabs.add(const Tab(
        text: 'General',
      ));
      if (qsType.value != '0') {
        tabs.add(const Tab(
          text: 'Quickshifter',
        ));
      }
      if (dsType.value != '0') {
        tabs.add(const Tab(
          text: 'Downshifter',
        ));
      }
    } else {
      tabs.add(const Tab(
        text: 'READ DATA FIRST',
      ));
    }
    return tabs;
  }
}
