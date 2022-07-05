import 'package:flutter/material.dart';
import 'package:qs_ds_app/model/constants_repository.dart';
import 'package:qs_ds_app/model/settings_repository.dart';
import 'package:qs_ds_app/screens/unlock_screen.dart';
import 'package:qs_ds_app/widgets/building_blocks/numeric_setting_widget.dart';

class GeneralWidget extends StatelessWidget {
  final Function() notifyParent;

  const GeneralWidget({Key? key, required this.notifyParent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 34, 0, 0),
              child: SizedBox(
                width: 480,
                child: Column(
                  children: [
                    NumericSetting(
                        setting: SettingsRepository().pulses,
                        notifyParent: notifyParent,
                        minAllowed: ConstantsRepository().pulsesNumericMin,
                        maxAllowed: ConstantsRepository().pulsesNumericMax,
                        step: getPulsesStep(SettingsRepository().pulses.value)),
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () {},
            onLongPress: () async {
              if (!SettingsRepository().systemUnlocked) {
                await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => UnlockScreen()));
              }
              notifyParent();
            },
            child: Text(
              'Ver. ${SettingsRepository().majorVersion.value}.${SettingsRepository().minorVersion.value}',
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
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
