import 'package:flutter/material.dart';
import 'package:qs_ds_app/model/settings_repository.dart';
import 'package:qs_ds_app/widgets/building_blocks/half_sensor_bar_widget.dart';

class SensorWidget extends StatelessWidget {
  const SensorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 70,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'RPM : ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  (double.tryParse(SettingsRepository().rpm.value) ?? 0.0) <
                          100000
                      ? (double.tryParse(SettingsRepository().rpm.value) ?? 0.0)
                          .toStringAsFixed(0)
                      : '0',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(80, 0, 80, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              HalfSensorBarWidget(
                quarterTurns: -2,
                reverse: true,
                isPush: true,
                color: Color(0xFF622D5D),
              ),
              HalfSensorBarWidget(
                quarterTurns: 0,
                reverse: false,
                isPush: false,
                color: Color(0xFF2D3C62),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
