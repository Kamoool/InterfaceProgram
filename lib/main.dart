import 'package:flutter/material.dart';
import 'package:qs_ds_app/screens/port_screen.dart';
import 'package:window_size/window_size.dart';
import 'dart:io' show Platform;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Quick-Down-Shifter App');
    setWindowFrame(const Rect.fromLTWH(100, 100, 1200, 730));
    setWindowMinSize(const Size(100, 100));

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
      title: 'Quick-Down-Shifter App',
      theme: ThemeData(
        scrollbarTheme: const ScrollbarThemeData(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 1,
          shadowColor: Colors.black,
          toolbarHeight: 0,
        ),
      ),
      home: const PortScreen(),
    );
  }
}
