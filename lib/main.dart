import 'package:flutter/material.dart';
import 'package:qs_ds_app/screens/port_screen.dart';
import 'package:qs_ds_app/screens/settings_screen.dart';
import 'package:window_size/window_size.dart';
import 'dart:io' show Platform;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Quick - Down - Shifter APP');
    setWindowMinSize(const Size(1050, 400));
    // setWindowMaxSize(const Size(1200, 730));
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 1,
          shadowColor: Colors.black,
          toolbarHeight: 0,
          // surfaceTintColor: Colors.red,
        ),
      ),
      // color: Colors.green,
      home: PortScreen(),
      // home: SettingsScreen(),
    );
  }
}
