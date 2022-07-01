import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'dart:async';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:qs_ds_app/widgets/downshifter_widget.dart';
import 'package:qs_ds_app/widgets/general_widget.dart';
import 'package:qs_ds_app/widgets/quickshifter_widget.dart';
import 'package:qs_ds_app/model/settings_repository.dart';
import 'package:qs_ds_app/widgets/sensor_widget.dart';

class SettingsScreen extends StatefulWidget {
  final SerialPort? serialPort;

  const SettingsScreen({Key? key, this.serialPort}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ScrollController scrollControllerHorizontal = ScrollController();
  final ScrollController scrollControllerVertical = ScrollController();
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
            refresh();
          }
        } else {
          b.add(
              Uint8List.fromList(stringList[stringList.length - 1].codeUnits));
          for (int i = 0; i < stringList.length - 1; i++) {
            settingsRepository.parseValues(stringList[i]);
            refresh();
          }
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
        child: DefaultTabController(
          length: settingsRepository.getTabs().length,
          child: Builder(builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {}
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
                  labelStyle: const TextStyle(fontSize: 25),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white70,
                  tabs: settingsRepository.getTabs(),
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
                    child: const Icon(Icons.get_app),
                    label: "Read",
                    labelStyle: const TextStyle(fontSize: 20),
                    labelBackgroundColor: Colors.yellow,
                    backgroundColor: Colors.yellow,
                    onTap: () {
                      widget.serialPort!.write(
                          Uint8List.fromList('R\n'.codeUnits),
                          timeout: 100);
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.save),
                    label: "Save",
                    labelStyle: const TextStyle(fontSize: 20),
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
                      child: const Icon(Icons.restart_alt),
                      label: "Reset",
                      labelStyle: const TextStyle(fontSize: 20),
                      labelBackgroundColor: Colors.blue,
                      backgroundColor: Colors.blue,
                      onTap: () {
                        widget.serialPort!.write(
                            Uint8List.fromList('W\n'.codeUnits),
                            timeout: 100);
                      }),
                  SpeedDialChild(
                      child: const Icon(Icons.exit_to_app),
                      label: "Disconnect",
                      labelStyle: const TextStyle(fontSize: 20),
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
              body: Scrollbar(
                controller: scrollControllerVertical,
                thumbVisibility: true,
                trackVisibility: true,
                child: Scrollbar(
                  controller: scrollControllerHorizontal,
                  scrollbarOrientation: ScrollbarOrientation.bottom,
                  thumbVisibility: true,
                  notificationPredicate: (notif) => notif.depth == 1,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollControllerVertical,
                    child: SingleChildScrollView(
                      controller: scrollControllerHorizontal,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width > 1110
                            ? MediaQuery.of(context).size.width
                            : 1110,
                        // width: 1100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height - 153) >
                                          540
                                      ? MediaQuery.of(context).size.height - 153
                                      : 540,
                              child: TabBarView(
                                children:
                                    settingsRepository.getTabs().map((Tab tab) {
                                  if (tab.text == 'General') {
                                    return GeneralWidget(notifyParent: refresh);
                                  }
                                  if (tab.text == 'Quickshifter') {
                                    return QuickshifterWidget(
                                      notifyParent: refresh,
                                      sendCutCommand: sendCutCommand,
                                    );
                                  }
                                  if (tab.text == 'Downshifter') {
                                    {
                                      return DownshifterWidget(
                                        notifyParent: refresh,
                                        sendBlipCommand: sendBlipCommand,
                                      );
                                    }
                                  }
                                  return const Center(
                                    child: Text(
                                      'READ DATA FIRST',
                                      style: TextStyle(
                                          fontSize: 50, color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 94,
                                // width: 1000,
                                child: SensorWidget(
                                    settingsRepository: settingsRepository),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
