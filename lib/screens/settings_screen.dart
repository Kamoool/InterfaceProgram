import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:qs_ds_app/screens/downshifter_screen.dart';
import 'package:qs_ds_app/screens/general_screen.dart';
import 'package:qs_ds_app/screens/quickshifter_screen.dart';
import 'package:qs_ds_app/model/settings_repository.dart';

class SettingsScreen extends StatefulWidget {
  final SerialPort? serialPort;

  const SettingsScreen({Key? key, this.serialPort}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double sliderValue = 20;
  bool readData = true;

  final SettingsRepository settingsRepository = SettingsRepository();
  bool positive = false;
  int value = 0;
  String sensorValue = '3000';

  @override
  void initState() {
    super.initState();
    _readFromPort();
  }

  void sendCutCommand() {
    widget.serialPort!.write(Uint8List.fromList('C\n'.codeUnits), timeout: 100);
  }

  void sendBlipCommand() {
    widget.serialPort!.write(Uint8List.fromList('B\n'.codeUnits), timeout: 100);
  }

  Future<void> _readFromPort() async {
    if (widget.serialPort == null) {
      return;
    }
    final reader = SerialPortReader(widget.serialPort!);
    var b = BytesBuilder();
    reader.stream.listen((Uint8List data) {
      b.add(data);
      if (String.fromCharCodes(b.toBytes()).contains('\r\n')) {
        List<String> stringList =
            String.fromCharCodes(b.toBytes()).split('\r\n');
        b.clear();
        if (stringList[stringList.length - 1] == '') {
          for (int i = 0; i < stringList.length - 1; i++) {
            settingsRepository.parseValues(stringList[i]);
            // print(stringList[i]);
            refresh();
          }
        } else {
          b.add(
              Uint8List.fromList(stringList[stringList.length - 1].codeUnits));
          for (int i = 0; i < stringList.length - 1; i++) {
            settingsRepository.parseValues(stringList[i]);
            // print(stringList[i]);
            refresh();
          }
          print('Pozostało: ${stringList[stringList.length - 1]}');
        }
      }
    });
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF676767),
                Color(0xFF676767),
                Color(0xFFA05A5A),
                Color(0xFF676767),
                Color(0xFF676767)
              ],
              begin: const FractionalOffset(0, 0),
              end: const FractionalOffset(1, 1),
              stops: [0, 0.25, 0.5, 0.75, 1],
              tileMode: TileMode.clamp),
        ),
        // constraints: BoxConstraints(
        //     minWidth: 1200, minHeight: 800, maxHeight: 800, maxWidth: 1200),
        // color: Colors.red,
        child: DefaultTabController(
          // length: tabs.length,
          length: settingsRepository.getTabs().length,
          // The Builder widget is used to have a different BuildContext to access
          // closest DefaultTabController.
          child: Builder(builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {
                // Your code goes here.
                // To get index of current tab use tabController.index
              }
            });
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                bottom: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(20)),
                  indicatorColor: Colors.red,
                  indicatorWeight: 3,
                  // // indicatorPadding: EdgeInsets.all(5),
                  labelStyle: TextStyle(fontSize: 25),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white70,
                  // overlayColor: Colors.yellow,
                  tabs: settingsRepository.getTabs(),
                  // tabs: tabs,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: SpeedDial(
                backgroundColor: Colors.black,
                overlayColor: Colors.black,
                overlayOpacity: 0.4,
                animatedIcon: AnimatedIcons.menu_close,
                children: [
                  SpeedDialChild(
                    child: Icon(Icons.get_app),
                    label: "Read",
                    labelStyle: TextStyle(fontSize: 20),
                    labelBackgroundColor: Colors.yellow,
                    backgroundColor: Colors.yellow,
                    onTap: () {
                      widget.serialPort!.write(
                          Uint8List.fromList('R\n'.codeUnits),
                          timeout: 100);
                    },
                  ),
                  SpeedDialChild(
                    child: Icon(Icons.save),
                    label: "Save",
                    labelStyle: TextStyle(fontSize: 20),
                    labelBackgroundColor: Colors.green,
                    backgroundColor: Colors.green,
                    onTap: () {
                      widget.serialPort!.write(
                          Uint8List.fromList(
                              '${settingsRepository.generateSaveSettings()}\n'
                                  .codeUnits),
                          timeout: 100);
                    },
                  ),
                  SpeedDialChild(
                      child: Icon(Icons.restart_alt),
                      label: "Reset",
                      labelStyle: TextStyle(fontSize: 20),
                      labelBackgroundColor: Colors.blue,
                      backgroundColor: Colors.blue,
                      onTap: () {
                        widget.serialPort!.write(
                            Uint8List.fromList('W\n'.codeUnits),
                            timeout: 100);
                      }),
                  SpeedDialChild(
                      child: Icon(Icons.exit_to_app),
                      label: "Disconnect",
                      labelStyle: TextStyle(fontSize: 20),
                      labelBackgroundColor: Colors.red,
                      backgroundColor: Colors.red,
                      onTap: () {
                        widget.serialPort!
                            .write(Uint8List.fromList('E\n'.codeUnits));
                        widget.serialPort!.close();
                        widget.serialPort!.dispose();
                        Navigator.pop(context);
                      }),
                ],
              ),
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        child: SizedBox(
                          // child: Expanded(

                          height: 540,
                          child: TabBarView(
                            children:
                                settingsRepository.getTabs().map((Tab tab) {
                              // children: tabs.map((Tab tab) {
                              if (tab.text == 'General') {
                                // return Center(
                                //   child: Text('General'),
                                // );
                                return GeneralScreenWidget(
                                    settingsRepository: settingsRepository,
                                    notifyParent: refresh);
                              }
                              if (tab.text == 'Quickshifter') {
                                return QuickshifterScreenWidget(
                                  settingsRepository: settingsRepository,
                                  notifyParent: refresh,
                                  sendCutCommand: sendCutCommand,
                                );
                              }
                              if (tab.text == 'Downshifter') {
                                {
                                  return DownshifterScreenWidget(
                                    settingsRepository: settingsRepository,
                                    notifyParent: refresh,
                                    sendBlipCommand: sendBlipCommand,
                                  );
                                }
                              }
                              return Center(
                                child: Text(
                                  'READ DATA FIRST',
                                  style: TextStyle(
                                      fontSize: 50, color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 94,
                            // width: 1000,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Text(
                                            'RPM : ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Text(
                                            (double.tryParse(settingsRepository
                                                            .rpm.value) ??
                                                        0.0) <
                                                    100000
                                                ? (double.tryParse(
                                                            settingsRepository
                                                                .rpm.value) ??
                                                        0.0)
                                                    .toStringAsFixed(0)
                                                : '0',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      100, 0, 100, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: RotatedBox(
                                                quarterTurns: -2,
                                                child: LinearProgressIndicator(
                                                  minHeight: 40,
                                                  // color: Colors.red,
                                                  // valueColor:
                                                  //     AlwaysStoppedAnimation<
                                                  //         Color>(Colors.yellow),
                                                  // color: Colors.yellow,
                                                  color: Color(0xFF622D5D),
                                                  backgroundColor:
                                                      Colors.black26,
                                                  value: -((double.tryParse(
                                                                  settingsRepository
                                                                      .sensorReading
                                                                      .value) ??
                                                              2000) -
                                                          2000) /
                                                      2000,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  (double.tryParse(settingsRepository
                                                                  .sensorReading
                                                                  .value) ??
                                                              2000) <
                                                          2000
                                                      ? 'Push : ${(-((double.tryParse(settingsRepository.sensorReading.value) ?? 2000) - 2000)).toStringAsFixed(0)}'
                                                      : '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: LinearProgressIndicator(
                                                minHeight: 40,
                                                // valueColor:
                                                //     AlwaysStoppedAnimation<
                                                //         Color>(Colors.blue),
                                                // color: Colors.blue,
                                                color: Color(0xFF2D3C62),
                                                backgroundColor: Colors.black26,
                                                value: ((double.tryParse(
                                                                settingsRepository
                                                                    .sensorReading
                                                                    .value) ??
                                                            2000) -
                                                        2000) /
                                                    2000,
                                              ),
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  (double.tryParse(settingsRepository
                                                                  .sensorReading
                                                                  .value) ??
                                                              2000) >
                                                          2000
                                                      ? 'Pull : ${((double.tryParse(settingsRepository.sensorReading.value) ?? 2000) - 2000).toStringAsFixed(0)}'
                                                      : '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
