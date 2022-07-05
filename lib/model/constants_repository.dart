class ConstantsRepository {
  static ConstantsRepository instance = ConstantsRepository.internal();

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

  //Average readings sensor numerics
  final double averageReadingsNumericMin = 1;
  final double averageReadingsNumericMax = 100;
  final double averageReadingsNumericStep = 1;

  //Sensor allowed numerics
  final double sensorAllowedNumericMin = 1;
  final double sensorAllowedNumericMax = 2047;
  final double sensorAllowedNumericStep = 1;

  //Sensor above numerics
  final double sensorAboveNumericMin = 0;
  final double sensorAboveNumericMax = 4095;
  final double sensorAboveNumericStep = 1;

  //Sensor below numerics
  final double sensorBelowNumericMin = 0;
  final double sensorBelowNumericMax = 4095;
  final double sensorBelowNumericStep = 1;

  //RPM Average numerics
  final double averageRPMNumericMin = 1;
  final double averageRPMNumericMax = 200;
  final double averageRPMNumericStep = 1;

  //DAC Adjustment numerics
  final double adjustmentDACNumericMin = 1;
  final double adjustmentDACNumericMax = 200;
  final double adjustmentDACNumericStep = 1;

  //Reading DAC numerics
  final double readingDACNumericMin = 1000;
  final double readingDACNumericMax = 500000;
  final double readingDACNumericStep = 1000;

  factory ConstantsRepository() {
    return instance;
  }

  ConstantsRepository.internal();
}
