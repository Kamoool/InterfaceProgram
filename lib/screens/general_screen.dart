import 'package:flutter/material.dart';
import 'package:qs_ds_app/model/settings_repository.dart';
import 'package:qs_ds_app/screens/additional_widgets/numeric_setting_widget.dart';

class GeneralScreenWidget extends StatelessWidget {
  final Function() notifyParent;
  final SettingsRepository settingsRepository;

  const GeneralScreenWidget(
      {Key? key, required this.settingsRepository, required this.notifyParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Container(
                // decoration: BoxDecoration(border: Border.all()),
                child: SizedBox(
                  width: 600,
                  child: Column(
                    children: [
                      NumericSettingWidget(
                          setting: settingsRepository.pulses,
                          notifyParent: notifyParent,
                          minAllowed: settingsRepository.pulsesNumericMin,
                          maxAllowed: settingsRepository.pulsesNumericMax,
                          // step: settingsRepository.pulsesNumericStep),
                          step: getPulsesStep(settingsRepository.pulses.value)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              // width: 400,
              child: Align(
                // left: 50,
                child: Text('Ver. ' +
                    settingsRepository.majorVersion.value +
                    '.' +
                    settingsRepository.minorVersion.value),
                alignment: Alignment.topRight,
                // right: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
  double getPulsesStep(String pulses){
    double pulsesValue = double.tryParse(pulses)?? 1;
    if(pulsesValue == 0.5){
      return 0.5;
    } else if (pulsesValue > 1){
      return 1;
    }
    return 0.5;
  }
}
