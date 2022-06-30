import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import 'package:flutter_spinbox/cupertino.dart';
import '../../model/setting.dart';

class NumericSettingWidget extends StatefulWidget {
  final Setting setting;
  final Function() notifyParent;
  final double minAllowed;
  final double maxAllowed;
  final double step;

  const NumericSettingWidget(
      {Key? key,
      required this.setting,
      required this.notifyParent,
      required this.minAllowed,
      required this.maxAllowed,
      required this.step})
      : super(key: key);

  @override
  State<NumericSettingWidget> createState() => _NumericSettingWidgetState();
}

class _NumericSettingWidgetState extends State<NumericSettingWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 280,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Text(
              '${widget.setting.label} - ',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          // height: 60,
          child: CupertinoSpinBox(
            // showButtons: false,
            decoration: BoxDecoration(
                color: Colors.white12, borderRadius: BorderRadius.circular(5)),
            textStyle: const TextStyle(fontSize: 25, color: Colors.white),
            spacing: 3,
            min: widget.minAllowed,
            max: widget.maxAllowed,
            step: widget.step,
            decimals: determineDecimals(widget.step),

            value: double.tryParse(widget.setting.value) ?? widget.minAllowed,

            onChanged: (double value) {
              if (value < widget.minAllowed) {
                value = widget.minAllowed;
              }
              if (value > widget.maxAllowed) {
                value = widget.maxAllowed;
              }
              setState(() {
                if (widget.step % 1 == 0) {
                  widget.setting.value = value.toStringAsFixed(0);
                } else {
                  widget.setting.value = value.toStringAsFixed(2);
                }

                widget.notifyParent();
              });
            },
          ),
        ),
      ],
    );
  }
}

int determineDecimals(double step) {
  if (step % 1 == 0) {
    return 0;
  } else {
    return 1;
  }
}
