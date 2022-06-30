class Setting {
  final SettingType type;
  String value;
  late final String label;

  Setting(this.type, this.value) {
    label = generateLabel(type);
  }
}

enum SettingType {
  RPM,
  Sensor,
  MajorVersion,
  MinorVersion,
  QSType,
  DSType,
  QSEnable,
  DSEnable,
  PushCheckQS,
  Pulses,
  PreDelayQS,
  CutTime1,
  CutTime2,
  CutTime3,
  CutTime4,
  CutTime5,
  CutTime6,
  CutTime7,
  CutTime8,
  QSForce,
  MinRPMQS,
  PreDelayDS,
  BlipTime1,
  BlipTime2,
  BlipTime3,
  BlipTime4,
  BlipTime5,
  BlipTime6,
  BlipTime7,
  BlipTime8,
  DSForce,
  MinRPMDS,
  MaxRPMDS,
  PostDelayQS,
  PostDelayDS
}

String generateLabel(SettingType settingType) {
  if (settingType == SettingType.RPM) {
    return 'RPM';
  } else if (settingType == SettingType.Sensor) {
    return 'Sensor value';
  } else if (settingType == SettingType.MajorVersion) {
    return 'Major Version';
  } else if (settingType == SettingType.MinorVersion) {
    return 'Minor Version';
  } else if (settingType == SettingType.QSType) {
    return 'QS Type';
  } else if (settingType == SettingType.DSType) {
    return 'DS Type';
  } else if (settingType == SettingType.QSEnable) {
    return 'Enabled';
  } else if (settingType == SettingType.DSEnable) {
    return 'Enabled';
  } else if (settingType == SettingType.PushCheckQS) {
    return 'QS Push';
  } else if (settingType == SettingType.Pulses) {
    return 'Pulses / RPM';
  } else if (settingType == SettingType.PreDelayQS) {
    return 'Pre-delay';
  } else if (settingType == SettingType.CutTime1) {
    return 'Cut Time at 2000';
  } else if (settingType == SettingType.CutTime2) {
    return 'Cut Time at 4000';
  } else if (settingType == SettingType.CutTime3) {
    return 'Cut Time at 6000';
  } else if (settingType == SettingType.CutTime4) {
    return 'Cut Time at 8000';
  } else if (settingType == SettingType.CutTime5) {
    return 'Cut Time at 10000';
  } else if (settingType == SettingType.CutTime6) {
    return 'Cut Time at 12000';
  } else if (settingType == SettingType.CutTime7) {
    return 'Cut Time at 14000';
  } else if (settingType == SettingType.CutTime8) {
    return 'Cut Time at 16000';
  } else if (settingType == SettingType.QSForce) {
    return 'Sensor threshold';
  } else if (settingType == SettingType.MinRPMQS) {
    return 'Minimum RPM';
  } else if (settingType == SettingType.PreDelayDS) {
    return 'Pre-delay';
  } else if (settingType == SettingType.BlipTime1) {
    return 'Blip Time at 2000';
  } else if (settingType == SettingType.BlipTime2) {
    return 'Blip Time at 4000';
  } else if (settingType == SettingType.BlipTime3) {
    return 'Blip Time at 6000';
  } else if (settingType == SettingType.BlipTime4) {
    return 'Blip Time at 8000';
  } else if (settingType == SettingType.BlipTime5) {
    return 'Blip Time at 10000';
  } else if (settingType == SettingType.BlipTime6) {
    return 'Blip Time at 12000';
  } else if (settingType == SettingType.BlipTime7) {
    return 'Blip Time at 14000';
  } else if (settingType == SettingType.BlipTime8) {
    return 'Blip Time at 16000';
  } else if (settingType == SettingType.DSForce) {
    return 'Sensor threshold';
  } else if (settingType == SettingType.MinRPMDS) {
    return 'Minimum RPM';
  } else if (settingType == SettingType.MaxRPMDS) {
    return 'Maximum RPM';
  } else if (settingType == SettingType.PostDelayQS) {
    return 'Post-delay';
  } else if (settingType == SettingType.PostDelayDS) {
    return 'Post-delay';
  } else {
    return 'Wrong Type';
  }
}
