import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:qs_ds_app/model/settings_repository.dart';

class SerialPortUtils {
  SerialPort serialPort;
  late Function()? notify;
  static SerialPortUtils? instance;
  late bool stopListener;

  SerialPortUtils.internal({required this.serialPort}) {
    SerialPortConfig config = SerialPortConfig();
    config.baudRate = 9600;
    config.bits = 8;
    config.stopBits = 1;
    config.parity = SerialPortParity.none;
    config.dtr = SerialPortDtr.on;
    config.setFlowControl(SerialPortFlowControl.none);
    serialPort.openReadWrite();
    serialPort.config = config;
    stopListener = false;
    attachPortListener();
  }

  factory SerialPortUtils({SerialPort? serialPort}) {
    if (instance == null && serialPort != null) {
      instance = SerialPortUtils.internal(serialPort: serialPort);
    }
    return instance!;
  }

  void setNotify(Function() notify) {
    this.notify = notify;
  }

  void disconnect() {
    stopListener = true;
    sendString('E');
    serialPort.close();
    serialPort.dispose();
    instance = null;
  }

  void cut(){
    sendString('C');
  }

  void blip(){
    sendString('B');
  }

  void readData(){
    sendString('R');
  }

  void saveSettings(){
    sendString(SettingsRepository().generateSaveSettings());
  }

  void resetSettings(){
    sendString('W');
  }

  void sendString(String string) {
    serialPort.write(Uint8List.fromList('$string\n'.codeUnits), timeout: 100);
  }

  Future<void> attachPortListener() async {
    final reader = SerialPortReader(serialPort);
    var b = BytesBuilder();
    reader.stream.listen((Uint8List data) {
      b.add(data);
      if (String.fromCharCodes(b.toBytes()).contains('\r\n')) {
        List<String> stringList =
            String.fromCharCodes(b.toBytes()).split('\r\n');
        b.clear();
        if (stringList[stringList.length - 1] == '') {
          for (int i = 0; i < stringList.length - 1; i++) {
            SettingsRepository().parseValues(stringList[i]);
            notify!();
          }
        } else {
          b.add(
              Uint8List.fromList(stringList[stringList.length - 1].codeUnits));
          for (int i = 0; i < stringList.length - 1; i++) {
            SettingsRepository().parseValues(stringList[i]);
            notify!();
          }
        }
      }
      if (stopListener) {
        reader.close();
      }
    });
  }
}
