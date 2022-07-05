import 'package:flutter/material.dart';
import 'package:qs_ds_app/model/constants_repository.dart';
import 'package:qs_ds_app/model/settings_repository.dart';
import 'package:qs_ds_app/widgets/building_blocks/numeric_setting_widget.dart';

class SystemWidget extends StatefulWidget {
  final Function() notifyParent;

  const SystemWidget({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<SystemWidget> createState() => _SystemWidgetState();
}

class _SystemWidgetState extends State<SystemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 480,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 34, 0, 0),
                    child: NumericSetting(
                        setting: SettingsRepository().averageReadingsSensor,
                        notifyParent: widget.notifyParent,
                        minAllowed: ConstantsRepository().averageReadingsNumericMin,
                        maxAllowed: ConstantsRepository().averageReadingsNumericMax,
                        step: ConstantsRepository().averageReadingsNumericStep),
                  ),
                  NumericSetting(
                      setting: SettingsRepository().sensorAllowedChange,
                      notifyParent: widget.notifyParent,
                      minAllowed: ConstantsRepository().sensorAllowedNumericMin,
                      maxAllowed: ConstantsRepository().sensorAllowedNumericMax,
                      step: ConstantsRepository().sensorAllowedNumericStep),
                  NumericSetting(
                      setting: SettingsRepository().sensorAboveAdjust,
                      notifyParent: widget.notifyParent,
                      minAllowed: ConstantsRepository().sensorAboveNumericMin,
                      maxAllowed: ConstantsRepository().sensorAboveNumericMax,
                      step: ConstantsRepository().sensorAboveNumericStep),
                  NumericSetting(
                      setting: SettingsRepository().sensorBelowAdjust,
                      notifyParent: widget.notifyParent,
                      minAllowed: ConstantsRepository().sensorBelowNumericMin,
                      maxAllowed: ConstantsRepository().sensorBelowNumericMax,
                      step: ConstantsRepository().sensorBelowNumericStep),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 40, 0, 0),
              child: Container(
                width: 2,
                height: 250,
                color: Colors.black38,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            SizedBox(
              width: 480,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 34, 0, 0),
                    child: NumericSetting(
                        setting: SettingsRepository().averageRPM,
                        notifyParent: widget.notifyParent,
                        minAllowed: ConstantsRepository().averageRPMNumericMin,
                        maxAllowed: ConstantsRepository().averageRPMNumericMax,
                        step: ConstantsRepository().averageRPMNumericStep),
                  ),
                  NumericSetting(
                      setting: SettingsRepository().dacAdjustmentValue,
                      notifyParent: widget.notifyParent,
                      minAllowed: ConstantsRepository().adjustmentDACNumericMin,
                      maxAllowed: ConstantsRepository().adjustmentDACNumericMax,
                      step: ConstantsRepository().adjustmentDACNumericStep),
                  NumericSetting(
                      setting: SettingsRepository().readingDAC,
                      notifyParent: widget.notifyParent,
                      minAllowed: ConstantsRepository().readingDACNumericMin,
                      maxAllowed: ConstantsRepository().readingDACNumericMax,
                      step: ConstantsRepository().readingDACNumericStep),
                  NumericSetting(
                      setting: SettingsRepository().readingDACConnected,
                      notifyParent: widget.notifyParent,
                      minAllowed: ConstantsRepository().readingDACNumericMin,
                      maxAllowed: ConstantsRepository().readingDACNumericMax,
                      step: ConstantsRepository().readingDACNumericStep),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
