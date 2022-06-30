import 'package:flutter/material.dart';
import 'package:qs_ds_app/model/settings_repository.dart';
import 'package:qs_ds_app/screens/additional_widgets/numeric_setting_widget.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:unicons/unicons.dart';

class DownshifterScreenWidget extends StatefulWidget {
  final Function() notifyParent;
  final SettingsRepository settingsRepository;
  final Function() sendBlipCommand;

  const DownshifterScreenWidget(
      {Key? key,
      required this.settingsRepository,
      required this.notifyParent,
      required this.sendBlipCommand})
      : super(key: key);

  @override
  State<DownshifterScreenWidget> createState() =>
      _DownshifterScreenWidgetState();
}

class _DownshifterScreenWidgetState extends State<DownshifterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 450,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: AnimatedToggleSwitch<bool>.dual(
                      current: widget.settingsRepository.dsEnable.value == '1',
                      first: false,
                      second: true,
                      dif: 70.0,
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
                          ? widget.settingsRepository.dsEnable.value = '1'
                          : widget.settingsRepository.dsEnable.value = '0'),
                      colorBuilder: (b) => b ? Colors.red : Colors.green,
                      iconBuilder: (value) => value
                          ? const Icon(
                              Icons.cancel_outlined,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.task_alt_outlined,
                              color: Colors.white,
                            ),
                      textBuilder: (value) => value
                          ? const Center(
                              child: Text(
                              'Disabled',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ))
                          : const Center(
                              child: Text(
                              'Enabled',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: AnimatedToggleSwitch<bool>.dual(
                      current:
                          widget.settingsRepository.pushCheckQS.value == '0',
                      first: true,
                      second: false,
                      dif: 70.0,
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
                          ? widget.settingsRepository.pushCheckQS.value = '0'
                          : widget.settingsRepository.pushCheckQS.value = '1'),
                      colorBuilder: (b) =>
                          b ? const Color(0xFF622D5D) : const Color(0xFF2D3C62),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ))
                          : const Center(
                              child: Text(
                              'Pull',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: TapDebouncer(
                    cooldown: const Duration(milliseconds: 500),
                    onTap: () async => await blipCommandCall(),
                    builder: (BuildContext context, TapDebouncerFunc? onTap) {
                      return ElevatedButton(
                        // onPressed: () {
                        //   print('On tap called');
                        // },
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 55),
                          primary: Colors.white38,
                          // primary: Colors.grey.shade200,
                          onPrimary: Colors.black12,
                          onSurface: Colors.red,
                          shadowColor: Colors.black,
                          elevation: 3,
                          side: const BorderSide(
                              color: Colors.transparent,
                              //change border color
                              width: 2,
                              //change border width
                              style: BorderStyle.solid),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), //change border radius of this beautiful button thanks to BorderRadius.circular function
                          ),
                          tapTargetSize: MaterialTapTargetSize.padded,
                        ),
                        child: onTap == null
                            ? const Text(
                                'Wait',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )
                            : const Text(
                                'Blip',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.dsForce,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.sensorNumericMin,
                    maxAllowed: widget.settingsRepository.sensorNumericMax,
                    step: widget.settingsRepository.sensorNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.minRPMDS,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.minRPMNumericMin,
                    maxAllowed: (double.tryParse(
                                widget.settingsRepository.maxRPMDS.value) ??
                            widget.settingsRepository.maxRPMNumericMax) -
                        500,
                    step: widget.settingsRepository.minRPMNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.maxRPMDS,
                    notifyParent: widget.notifyParent,
                    minAllowed: (double.tryParse(
                                widget.settingsRepository.minRPMDS.value) ??
                            widget.settingsRepository.minRPMNumericMin) +
                        500,
                    // minAllowed: widget.settingsRepository.maxRPMNumericMin,
                    maxAllowed: widget.settingsRepository.maxRPMNumericMax,
                    step: widget.settingsRepository.maxRPMNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.preDelayDS,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.preDelayNumericMin,
                    maxAllowed: widget.settingsRepository.preDelayNumericMax,
                    step: widget.settingsRepository.preDelayNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.postDelayDS,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.postDelayNumericMin,
                    maxAllowed: widget.settingsRepository.postDelayNumericMax,
                    step: widget.settingsRepository.postDelayNumericStep),
              ),
            ],
            // children: List.from(settingsMap.values.map((e) => NumericSettingWidget(setting: e, notifyParent: notifyParent, minAllowed: 0.5, maxAllowed: 5, step: 0.5))),
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
          width: 450,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 39, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.blipTime1,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.dsBlipNumericMin,
                    maxAllowed: widget.settingsRepository.dsBlipNumericMax,
                    step: widget.settingsRepository.dsBlipNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.blipTime2,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.dsBlipNumericMin,
                    maxAllowed: widget.settingsRepository.dsBlipNumericMax,
                    step: widget.settingsRepository.dsBlipNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.blipTime3,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.dsBlipNumericMin,
                    maxAllowed: widget.settingsRepository.dsBlipNumericMax,
                    step: widget.settingsRepository.dsBlipNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.blipTime4,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.dsBlipNumericMin,
                    maxAllowed: widget.settingsRepository.dsBlipNumericMax,
                    step: widget.settingsRepository.dsBlipNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.blipTime5,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.dsBlipNumericMin,
                    maxAllowed: widget.settingsRepository.dsBlipNumericMax,
                    step: widget.settingsRepository.dsBlipNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.blipTime6,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.dsBlipNumericMin,
                    maxAllowed: widget.settingsRepository.dsBlipNumericMax,
                    step: widget.settingsRepository.dsBlipNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.blipTime7,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.dsBlipNumericMin,
                    maxAllowed: widget.settingsRepository.dsBlipNumericMax,
                    step: widget.settingsRepository.dsBlipNumericStep),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: NumericSettingWidget(
                    setting: widget.settingsRepository.blipTime8,
                    notifyParent: widget.notifyParent,
                    minAllowed: widget.settingsRepository.dsBlipNumericMin,
                    maxAllowed: widget.settingsRepository.dsBlipNumericMax,
                    step: widget.settingsRepository.dsBlipNumericStep),
              ),
            ],
            // children: List.from(settingsMap.values.map((e) => NumericSettingWidget(setting: e, notifyParent: notifyParent, minAllowed: 0.5, maxAllowed: 5, step: 0.5))),
          ),
        ),
      ],
    );
  }

  Future<void> blipCommandCall() async {
    widget.sendBlipCommand();
  }
}
