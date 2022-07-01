import 'package:flutter/material.dart';
import 'package:qs_ds_app/model/settings_repository.dart';
import 'package:qs_ds_app/widgets/building_blocks/numeric_setting_widget.dart';

class GeneralWidget extends StatelessWidget {
  final Function() notifyParent;
  final SettingsRepository settingsRepository;

  const GeneralWidget(
      {Key? key, required this.settingsRepository, required this.notifyParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: SizedBox(
                width: 480,
                child: Column(
                  children: [
                    NumericSetting(
                        setting: settingsRepository.pulses,
                        notifyParent: notifyParent,
                        minAllowed: settingsRepository.pulsesNumericMin,
                        maxAllowed: settingsRepository.pulsesNumericMax,
                        step: getPulsesStep(settingsRepository.pulses.value)),
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Text(
              'Ver. ${settingsRepository.majorVersion.value}.${settingsRepository.minorVersion.value}'),
        ),
      ],
    );
  }

  double getPulsesStep(String pulses) {
    double pulsesValue = double.tryParse(pulses) ?? 1;
    if (pulsesValue == 0.5) {
      return 0.5;
    } else if (pulsesValue > 1) {
      return 1;
    }
    return 0.5;
  }
}
