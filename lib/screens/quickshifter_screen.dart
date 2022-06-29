import 'package:flutter/material.dart';
import 'package:qs_ds_app/model/settings_repository.dart';
import 'package:qs_ds_app/screens/additional_widgets/numeric_setting_widget.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:unicons/unicons.dart';

class QuickshifterScreenWidget extends StatefulWidget {
  final Function() notifyParent;
  final SettingsRepository settingsRepository;
  final Function() sendCutCommand;

  const QuickshifterScreenWidget(
      {Key? key, required this.settingsRepository, required this.notifyParent, required this.sendCutCommand})
      : super(key: key);

  @override
  State<QuickshifterScreenWidget> createState() =>
      _QuickshifterScreenWidgetState();
}

class _QuickshifterScreenWidgetState extends State<QuickshifterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          current:
                              widget.settingsRepository.qsEnable.value == '1',
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
                              ? widget.settingsRepository.qsEnable.value = '1'
                              : widget.settingsRepository.qsEnable.value = '0'),
                          colorBuilder: (b) => b ? Colors.red : Colors.green,
                          iconBuilder: (value) => value
                              ? Icon(Icons.cancel_outlined, color: Colors.white,)
                              : Icon(Icons.task_alt_outlined, color: Colors.white,),
                          textBuilder: (value) => value
                              ? Center(
                                  child: Text(
                                  'Disabled',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ))
                              : Center(
                                  child: Text(
                                  'Enabled',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current:
                              widget.settingsRepository.pushCheckQS.value ==
                                  '1',
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
                              ? widget.settingsRepository.pushCheckQS.value =
                                  '1'
                              : widget.settingsRepository.pushCheckQS.value =
                                  '0'),
                          colorBuilder: (b) => b ? Color(0xFF622D5D) : Color(0xFF2D3C62),
                          iconBuilder: (value) => value
                              ? Icon(UniconsLine.compress_alt, color: Colors.white,)
                              : Icon(UniconsLine.expand_alt, color: Colors.white,),
                          textBuilder: (value) => value
                              ? Center(
                                  child: Text(
                                  'Push',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ))
                              : Center(
                                  child: Text(
                                  'Pull',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
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
                        onTap: () async => await cutCommandCall(),
                        // onTap: cutCommandCall(),
                        builder: (BuildContext context, TapDebouncerFunc? onTap){
                          return ElevatedButton(
                            // onPressed: () {
                            //   print('On tap called');
                            // },
                            onPressed: onTap,
                            child: onTap == null? const Text(
                              'Wait', style: TextStyle(color: Colors.white, fontSize: 25),
                            ) : const Text(
                              'Cut', style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 55),
                              primary: Colors.white38,
                              // primary: Colors.grey.shade200,
                              onPrimary: Colors.black12,
                              onSurface: Colors.red,
                              shadowColor: Colors.black,
                              elevation: 3,
                              side: BorderSide(
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
                          );
                        },
                      ),


                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.qsForce,
                        notifyParent: widget.notifyParent,
                        minAllowed: widget.settingsRepository.sensorNumericMin,
                        maxAllowed: widget.settingsRepository.sensorNumericMax,
                        step: widget.settingsRepository.sensorNumericStep),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.minRPMQS,
                        notifyParent: widget.notifyParent,
                        minAllowed: widget.settingsRepository.minRPMNumericMin,
                        maxAllowed: widget.settingsRepository.minRPMNumericMax,
                        step: widget.settingsRepository.minRPMNumericStep),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.preDelayQS,
                        notifyParent: widget.notifyParent,
                        minAllowed:
                            widget.settingsRepository.preDelayNumericMin,
                        maxAllowed:
                            widget.settingsRepository.preDelayNumericMax,
                        step: widget.settingsRepository.preDelayNumericStep),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.postDelayQS,
                        notifyParent: widget.notifyParent,
                        minAllowed:
                            widget.settingsRepository.postDelayNumericMin,
                        maxAllowed:
                            widget.settingsRepository.postDelayNumericMax,
                        step: widget.settingsRepository.postDelayNumericStep),
                  ),
                ],
                // children: List.from(settingsMap.values.map((e) => NumericSettingWidget(setting: e, notifyParent: notifyParent, minAllowed: 0.5, maxAllowed: 5, step: 0.5))),
              ),
            ),
            SizedBox(
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
            SizedBox(
              width: 30,
            ),
            SizedBox(
              width: 450,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 39, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.cutTime1,
                        notifyParent: widget.notifyParent,
                        minAllowed: widget.settingsRepository.qsCutNumericMin,
                        maxAllowed: widget.settingsRepository.qsCutNumericMax,
                        step: widget.settingsRepository.qsCutNumericStep),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.cutTime2,
                        notifyParent: widget.notifyParent,
                        minAllowed: widget.settingsRepository.qsCutNumericMin,
                        maxAllowed: widget.settingsRepository.qsCutNumericMax,
                        step: widget.settingsRepository.qsCutNumericStep),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.cutTime3,
                        notifyParent: widget.notifyParent,
                        minAllowed: widget.settingsRepository.qsCutNumericMin,
                        maxAllowed: widget.settingsRepository.qsCutNumericMax,
                        step: widget.settingsRepository.qsCutNumericStep),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.cutTime4,
                        notifyParent: widget.notifyParent,
                        minAllowed: widget.settingsRepository.qsCutNumericMin,
                        maxAllowed: widget.settingsRepository.qsCutNumericMax,
                        step: widget.settingsRepository.qsCutNumericStep),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.cutTime5,
                        notifyParent: widget.notifyParent,
                        minAllowed: widget.settingsRepository.qsCutNumericMin,
                        maxAllowed: widget.settingsRepository.qsCutNumericMax,
                        step: widget.settingsRepository.qsCutNumericStep),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.cutTime6,
                        notifyParent: widget.notifyParent,
                        minAllowed: widget.settingsRepository.qsCutNumericMin,
                        maxAllowed: widget.settingsRepository.qsCutNumericMax,
                        step: widget.settingsRepository.qsCutNumericStep),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.cutTime7,
                        notifyParent: widget.notifyParent,
                        minAllowed: widget.settingsRepository.qsCutNumericMin,
                        maxAllowed: widget.settingsRepository.qsCutNumericMax,
                        step: widget.settingsRepository.qsCutNumericStep),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: NumericSettingWidget(
                        setting: widget.settingsRepository.cutTime8,
                        notifyParent: widget.notifyParent,
                        minAllowed: widget.settingsRepository.qsCutNumericMin,
                        maxAllowed: widget.settingsRepository.qsCutNumericMax,
                        step: widget.settingsRepository.qsCutNumericStep),
                  ),
                ],
                // children: List.from(settingsMap.values.map((e) => NumericSettingWidget(setting: e, notifyParent: notifyParent, minAllowed: 0.5, maxAllowed: 5, step: 0.5))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cutCommandCall() async {
    widget.sendCutCommand();
  }

  // void cutCommandCall() async {
  //   widget.sendCutCommand;
  // }

}
