import 'package:flutter/material.dart';
import 'package:qs_ds_app/model/constants_repository.dart';
import 'package:qs_ds_app/model/serial_port_utils.dart';
import 'package:qs_ds_app/model/settings_repository.dart';
import 'package:qs_ds_app/widgets/building_blocks/numeric_setting_widget.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:unicons/unicons.dart';

class DownshifterWidget extends StatefulWidget {
  final Function() notifyParent;

  const DownshifterWidget({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<DownshifterWidget> createState() => _DownshifterWidgetState();
}

class _DownshifterWidgetState extends State<DownshifterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: SizedBox(
            width: 480,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedToggleSwitch<bool>.dual(
                      current: SettingsRepository().dsEnable.value == '1',
                      first: true,
                      second: false,
                      dif: 80.0,
                      borderColor: Colors.transparent,
                      borderWidth: 1.0,
                      height: 55,
                      innerColor: Colors.white38,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 0.8,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                      onChanged: (b) => setState(() => b
                          ? SettingsRepository().dsEnable.value = '1'
                          : SettingsRepository().dsEnable.value = '0'),
                      colorBuilder: (b) => b ? Colors.red : Colors.green,
                      iconBuilder: (value) => value
                          ? const Icon(
                              Icons.task_alt_outlined,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.cancel_outlined,
                              color: Colors.white,
                            ),
                      textBuilder: (value) => value
                          ? const Center(
                              child: Text(
                              'Enabled',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ))
                          : const Center(
                              child: Text(
                              'Disabled',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            )),
                    ),
                    AnimatedToggleSwitch<bool>.dual(
                      current: SettingsRepository().pushCheckQS.value == '0',
                      first: true,
                      second: false,
                      dif: 80.0,
                      borderColor: Colors.transparent,
                      borderWidth: 1.0,
                      height: 55,
                      innerColor: Colors.white38,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 0.8,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                      onChanged: (b) => setState(() => b
                          ? SettingsRepository().pushCheckQS.value = '0'
                          : SettingsRepository().pushCheckQS.value = '1'),
                      colorBuilder: (b) => b ? const Color(0xFF622D5D) : const Color(0xFF2D3C62),
                      iconBuilder: (value) => value
                          ? const Icon(
                              UniconsLine.compress_alt,
                              color: Colors.white,
                            )
                          : const Icon(
                              UniconsLine.expand_alt,
                              color: Colors.white,
                            ),
                      textBuilder: (value) => value
                          ? const Center(
                              child: Text(
                              'Push',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ))
                          : const Center(
                              child: Text(
                              'Pull',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TapDebouncer(
                        cooldown: const Duration(milliseconds: 500),
                        onTap: () async => await blipCommandCall(),
                        builder: (BuildContext context, TapDebouncerFunc? onTap) {
                          return ElevatedButton(
                            onPressed: onTap,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 55),
                              primary: Colors.white38,
                              onPrimary: Colors.black12,
                              onSurface: Colors.red,
                              shadowColor: Colors.black,
                              elevation: 3,
                              side: const BorderSide(
                                  color: Colors.transparent, width: 2, style: BorderStyle.solid),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              tapTargetSize: MaterialTapTargetSize.padded,
                            ),
                            child: onTap == null
                                ? const Text(
                                    'Wait',
                                    style: TextStyle(color: Colors.white, fontSize: 25),
                                  )
                                : const Text(
                                    'Blip',
                                    style: TextStyle(color: Colors.white, fontSize: 25),
                                  ),
                          );
                        },
                      ),
                      TapDebouncer(
                        cooldown: const Duration(milliseconds: 100),
                        onTap: () async => await setSensor(),
                        builder: (BuildContext context, TapDebouncerFunc? onTap) {
                          return ElevatedButton(
                            onPressed:
                                (double.tryParse(SettingsRepository().sensorReading.value) != 2000)
                                    ? onTap
                                    : null,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 55),
                              primary: Colors.white38,
                              onPrimary: Colors.black12,
                              onSurface: Colors.red,
                              shadowColor: Colors.black,
                              elevation: 3,
                              side: const BorderSide(
                                  color: Colors.transparent, width: 2, style: BorderStyle.solid),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              tapTargetSize: MaterialTapTargetSize.padded,
                            ),
                            child: onTap == null
                                ? const Text(
                                    'Wait',
                                    style: TextStyle(color: Colors.white, fontSize: 25),
                                  )
                                : const Text(
                                    'Set sensor',
                                    style: TextStyle(color: Colors.white, fontSize: 25),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                NumericSetting(
                    setting: SettingsRepository().dsForce,
                    notifyParent: widget.notifyParent,
                    minAllowed: ConstantsRepository().sensorNumericMin,
                    maxAllowed: ConstantsRepository().sensorNumericMax,
                    step: ConstantsRepository().sensorNumericStep),
                NumericSetting(
                    setting: SettingsRepository().minRPMDS,
                    notifyParent: widget.notifyParent,
                    minAllowed: ConstantsRepository().minRPMNumericMin,
                    maxAllowed: (double.tryParse(SettingsRepository().maxRPMDS.value) ??
                            ConstantsRepository().maxRPMNumericMax) -
                        500,
                    step: ConstantsRepository().minRPMNumericStep),
                NumericSetting(
                    setting: SettingsRepository().maxRPMDS,
                    notifyParent: widget.notifyParent,
                    minAllowed: (double.tryParse(SettingsRepository().minRPMDS.value) ??
                            ConstantsRepository().minRPMNumericMin) +
                        500,
                    maxAllowed: ConstantsRepository().maxRPMNumericMax,
                    step: ConstantsRepository().maxRPMNumericStep),
                NumericSetting(
                    setting: SettingsRepository().preDelayDS,
                    notifyParent: widget.notifyParent,
                    minAllowed: ConstantsRepository().preDelayNumericMin,
                    maxAllowed: ConstantsRepository().preDelayNumericMax,
                    step: ConstantsRepository().preDelayNumericStep),
                NumericSetting(
                    setting: SettingsRepository().postDelayDS,
                    notifyParent: widget.notifyParent,
                    minAllowed: ConstantsRepository().postDelayNumericMin,
                    maxAllowed: ConstantsRepository().postDelayNumericMax,
                    step: ConstantsRepository().postDelayNumericStep),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 40, 0, 0),
          child: Container(
            width: 2,
            height: 480,
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
                    setting: SettingsRepository().blipTime1,
                    notifyParent: widget.notifyParent,
                    minAllowed: ConstantsRepository().dsBlipNumericMin,
                    maxAllowed: ConstantsRepository().dsBlipNumericMax,
                    step: ConstantsRepository().dsBlipNumericStep),
              ),
              NumericSetting(
                  setting: SettingsRepository().blipTime2,
                  notifyParent: widget.notifyParent,
                  minAllowed: ConstantsRepository().dsBlipNumericMin,
                  maxAllowed: ConstantsRepository().dsBlipNumericMax,
                  step: ConstantsRepository().dsBlipNumericStep),
              NumericSetting(
                  setting: SettingsRepository().blipTime3,
                  notifyParent: widget.notifyParent,
                  minAllowed: ConstantsRepository().dsBlipNumericMin,
                  maxAllowed: ConstantsRepository().dsBlipNumericMax,
                  step: ConstantsRepository().dsBlipNumericStep),
              NumericSetting(
                  setting: SettingsRepository().blipTime4,
                  notifyParent: widget.notifyParent,
                  minAllowed: ConstantsRepository().dsBlipNumericMin,
                  maxAllowed: ConstantsRepository().dsBlipNumericMax,
                  step: ConstantsRepository().dsBlipNumericStep),
              NumericSetting(
                  setting: SettingsRepository().blipTime5,
                  notifyParent: widget.notifyParent,
                  minAllowed: ConstantsRepository().dsBlipNumericMin,
                  maxAllowed: ConstantsRepository().dsBlipNumericMax,
                  step: ConstantsRepository().dsBlipNumericStep),
              NumericSetting(
                  setting: SettingsRepository().blipTime6,
                  notifyParent: widget.notifyParent,
                  minAllowed: ConstantsRepository().dsBlipNumericMin,
                  maxAllowed: ConstantsRepository().dsBlipNumericMax,
                  step: ConstantsRepository().dsBlipNumericStep),
              NumericSetting(
                  setting: SettingsRepository().blipTime7,
                  notifyParent: widget.notifyParent,
                  minAllowed: ConstantsRepository().dsBlipNumericMin,
                  maxAllowed: ConstantsRepository().dsBlipNumericMax,
                  step: ConstantsRepository().dsBlipNumericStep),
              NumericSetting(
                  setting: SettingsRepository().blipTime8,
                  notifyParent: widget.notifyParent,
                  minAllowed: ConstantsRepository().dsBlipNumericMin,
                  maxAllowed: ConstantsRepository().dsBlipNumericMax,
                  step: ConstantsRepository().dsBlipNumericStep),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> blipCommandCall() async {
    SerialPortUtils().blip();
  }

  Future<void> setSensor() async {
    if (double.tryParse(SettingsRepository().sensorReading.value)! != 2000) {
      SettingsRepository().dsForce.value =
          (((double.tryParse(SettingsRepository().sensorReading.value)! > 2000) ? 1 : -1) *
                  (double.tryParse(SettingsRepository().sensorReading.value)! - 2000))
              .toString();
      SettingsRepository().pushCheckQS.value =
          (double.tryParse(SettingsRepository().sensorReading.value)! > 2000) ? '1' : '0';
    }
  }
}
