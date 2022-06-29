import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

void main() {
  // final name = SerialPort.availablePorts.first;
  final name = 'COM9';
  final port = SerialPort(name);
  if (!port.openReadWrite()) {
    print(SerialPort.lastError);
  }
  SerialPortConfig config = SerialPortConfig();
  config.baudRate = 9600;
  config.bits = 8;
  config.stopBits = 1;
  config.parity = SerialPortParity.none;
  config.dtr = SerialPortDtr.on;
  config.setFlowControl(SerialPortFlowControl.none);
  port.config = config;

  port.write(Uint8List.fromList('Onomatopejaqwertasdgaerfg'.codeUnits));

  final reader = SerialPortReader(port);
  // int i = 0;
  var b = BytesBuilder();
  // Uint8List datas = Uint8List.fromList([]);
  reader.stream.listen((data) {
    b.add(data);
    // datas.addAll(Uint8List.fromList('${i}'.codeUnits));
    // i++;
    // print('received: $data');
    if(String.fromCharCodes(b.toBytes()).contains('\n')){
      List<String> stringList = String.fromCharCodes(b.toBytes()).split('\n');
      b.clear();
      if(stringList[stringList.length-1] == ''){
        for(int i = 0; i < stringList.length-1; i++){
          print('${i}-ty element: ${stringList[i]}');
        }
      } else{
        b.add(Uint8List.fromList(stringList[stringList.length-1].codeUnits));
        for(int i = 0; i < stringList.length-1; i++){
          print('${i}-ty element: ${stringList[i]}');
        }
        print('Pozostało: ${stringList[stringList.length-1]}');
      }
    }
    // if (i == 5) {
    //   List<String> stringList = String.fromCharCodes(b.toBytes()).split('\n');
    //   print('This is the last element \' ${stringList[stringList.length-1]}\'');
    //   // print('Pierwszy element: ${stringList[0]}');
    //   // print('Drugi element: ${stringList[1]}');
    //   // print('Trzeci element: ${stringList[2]}');
    //   // print('Czwarty element: ${stringList[3]}');
    //   // print('Piąty element: ${stringList[4]}');
    //   // print('${String.fromCharCodes(b.toBytes())}');
    //   b.clear();
    //   i = 0;
    // }
  });
}
