import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:qs_ds_app/model/serial_utils.dart';
import 'package:qs_ds_app/screens/settings_screen.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class PortScreen extends StatefulWidget {
  const PortScreen({Key? key}) : super(key: key);

  @override
  State<PortScreen> createState() => _PortScreenState();
}

class _PortScreenState extends State<PortScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollControllerHorizontal = ScrollController();
  SerialPort? dropdownValue;
  List<SerialPort> availablePorts = [];
  late AnimationController animationController;
  bool refreshPressed = false;

  @override
  void initState() {
    super.initState();
    initPorts();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 300),
    );
  }

  void initPorts() {
    setState(() {
      availablePorts.clear();
      for (final address in SerialPort.availablePorts) {
        availablePorts.add(SerialPort(address));
      }
      dropdownValue = null;
    });
  }

  Future<void> revertRefresh() {
    return Future.delayed(
        const Duration(seconds: 2), () => animationController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: scrollControllerHorizontal,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        thumbVisibility: true,
        trackVisibility: true,
        child: SingleChildScrollView(
          controller: scrollControllerHorizontal,
          scrollDirection: Axis.horizontal,
          child: Container(
            width: MediaQuery.of(context).size.width > 540
                ? MediaQuery.of(context).size.width
                : 540,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF676767),
                    Color(0xFF676767),
                    Color(0xFFA05A5A),
                    Color(0xFF676767),
                    Color(0xFF676767)
                  ],
                  begin: FractionalOffset(0, 0),
                  end: FractionalOffset(1, 1),
                  stops: [0, 0.25, 0.5, 0.75, 1],
                  tileMode: TileMode.clamp),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                    child: AnimatedIconButton(
                      animationController: animationController,
                      size: 35,
                      initialIcon: 0,
                      onPressed: () {
                        initPorts();
                        animationController.reverse();
                        refreshPressed = true;
                        revertRefresh();
                      },
                      splashColor: Colors.blueAccent,
                      icons: const <AnimatedIconItem>[
                        AnimatedIconItem(
                          icon: Icon(Icons.refresh, color: Colors.black),
                        ),
                        AnimatedIconItem(
                          icon: Icon(Icons.task_alt, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
                              child: Text(
                                'Select Port',
                                style: TextStyle(
                                  fontSize: 20,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      items: availablePorts
                          .map((item) => DropdownMenuItem<SerialPort>(
                                value: item,
                                child: Text(
                                  item.description ?? 'Unknown',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: dropdownValue,
                      onChanged: (SerialPort? value) {
                        setState(() {
                          dropdownValue = value ?? SerialPort('COM0');
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 20,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.black,
                      buttonHeight: 45,
                      buttonWidth: 300,
                      buttonPadding: const EdgeInsets.only(left: 30, right: 30),
                      buttonDecoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 0.8,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: Colors.transparent,
                        ),
                        color: Colors.grey.shade200,
                      ),
                      buttonElevation: 10,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 30, right: 30),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 300,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade50,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(0, 0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TapDebouncer(
                      cooldown: const Duration(milliseconds: 1000),
                      onTap: () async => await establishConnection(),
                      builder: (BuildContext context, TapDebouncerFunc? onTap) {
                        return ElevatedButton(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 55),
                            primary: Colors.grey.shade200,
                            onPrimary: Colors.black12,
                            onSurface: Colors.green,
                            shadowColor: Colors.black,
                            elevation: 3,
                            side: const BorderSide(
                                color: Colors.transparent,
                                width: 2,
                                style: BorderStyle.solid),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            tapTargetSize: MaterialTapTargetSize.padded,
                          ),
                          child: onTap == null
                              ? const Text(
                                  'Wait',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )
                              : const Text(
                                  'Connect',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> establishConnection() async {
    if (dropdownValue != null) {
      SerialPortUtils(serialPort: dropdownValue);
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsScreen()));
      initPorts();
    }
  }
}
