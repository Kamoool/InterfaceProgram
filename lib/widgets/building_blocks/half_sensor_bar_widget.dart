import 'package:flutter/material.dart';
import 'package:qs_ds_app/model/settings_repository.dart';

class HalfSensorBarWidget extends StatelessWidget {
  const HalfSensorBarWidget({
    Key? key,
    required this.quarterTurns,
    required this.reverse,
    required this.isPush,
    required this.color,
  }) : super(key: key);

  final int quarterTurns;
  final bool reverse;
  final bool isPush;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: quarterTurns,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: LinearProgressIndicator(
                  minHeight: 40,
                  color: color,
                  backgroundColor: Colors.black26,
                  value: (reverse ? -1 : 1) *
                      ((double.tryParse(
                                  SettingsRepository().sensorReading.value) ??
                              2000) -
                          2000) /
                      2000,
                ),
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                (isPush
                        ? (double.tryParse(
                                    SettingsRepository().sensorReading.value) ??
                                2000) <
                            2000
                        : (double.tryParse(
                                    SettingsRepository().sensorReading.value) ??
                                2000) >
                            2000)
                    ? '${isPush ? 'Push' : 'Pull'} : ${((reverse ? -1 : 1) * ((double.tryParse(SettingsRepository().sensorReading.value) ?? 2000) - 2000)).toStringAsFixed(0)}'
                    : '',
                style: const TextStyle(color: Colors.white, fontSize: 25),
              )),
        ],
      ),
    );
  }
}
