import 'package:flutter/material.dart';

import '../model/setting.dart';

class SettingsRepository {
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

  SettingsRepository() {
    // settingsMap = {
    //   SettingType.RPM: Setting(SettingType.RPM, '1234'),
    //   SettingType.Sensor: Setting(SettingType.Sensor, '120'),
    //   SettingType.MajorVersion: Setting(SettingType.MajorVersion, '1'),
    //   SettingType.MinorVersion: Setting(SettingType.MinorVersion, '9'),
    //   SettingType.QSType: Setting(SettingType.QSType, '1'),
    //   SettingType.DSType: Setting(SettingType.DSType, '1'),
    //   SettingType.QSEnable: Setting(SettingType.QSEnable, '1'),
    //   SettingType.DSEnable: Setting(SettingType.DSEnable, '1'),
    //   SettingType.PushCheckQS: Setting(SettingType.PushCheckQS, '1'),
    //   SettingType.Pulses: Setting(SettingType.Pulses, '2'),
    //   SettingType.PreDelayQS: Setting(SettingType.PreDelayQS, '5'),
    //   SettingType.CutTime1: Setting(SettingType.CutTime1, '70'),
    //   SettingType.CutTime2: Setting(SettingType.CutTime2, '70'),
    //   SettingType.CutTime3: Setting(SettingType.CutTime3, '70'),
    //   SettingType.CutTime4: Setting(SettingType.CutTime4, '70'),
    //   SettingType.CutTime5: Setting(SettingType.CutTime5, '70'),
    //   SettingType.CutTime6: Setting(SettingType.CutTime6, '70'),
    //   SettingType.CutTime7: Setting(SettingType.CutTime7, '70'),
    //   SettingType.CutTime8: Setting(SettingType.CutTime8, '70'),
    //   SettingType.QSForce: Setting(SettingType.QSForce, '100'),
    //   SettingType.MinRPMQS: Setting(SettingType.MinRPMQS, '4000'),
    //   SettingType.PreDelayDS: Setting(SettingType.PreDelayDS, '5'),
    //   SettingType.BlipTime1: Setting(SettingType.BlipTime1, '80'),
    //   SettingType.BlipTime2: Setting(SettingType.BlipTime2, '80'),
    //   SettingType.BlipTime3: Setting(SettingType.BlipTime3, '80'),
    //   SettingType.BlipTime4: Setting(SettingType.BlipTime4, '80'),
    //   SettingType.BlipTime5: Setting(SettingType.BlipTime5, '80'),
    //   SettingType.BlipTime6: Setting(SettingType.BlipTime6, '80'),
    //   SettingType.BlipTime7: Setting(SettingType.BlipTime7, '80'),
    //   SettingType.BlipTime8: Setting(SettingType.BlipTime8, '80'),
    //   SettingType.DSForce: Setting(SettingType.DSForce, '100'),
    //   SettingType.MinRPMDS: Setting(SettingType.MinRPMDS, '4000'),
    //   SettingType.MaxRPMDS: Setting(SettingType.MinRPMQS, '10000'),
    //   SettingType.PostDelayQS: Setting(SettingType.PostDelayQS, '500'),
    //   SettingType.PostDelayDS: Setting(SettingType.PostDelayDS, '500'),
    // };
    settingsList = [
      // rpm,
      // sensorReading,
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
        // if(i == values.length - 1){
        //   values[i] = values[i].substring(0, values[i].length - 1);
        // }
        readingsList[i - 1].value = values[i];
      }
    } else if (values[0] == 'T' && values.length == settingsList.length + 1) {
      for (int i = 1; i < values.length; i++) {
        // if(i == values.length - 1){
        //   values[i] = values[i].substring(0, values[i].length - 1);
        // }
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
    // tabs.add(Tab(text: 'Quickshifter',));
    // tabs.add(Tab(text: 'Downshifter',));
    // return tabs;
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
