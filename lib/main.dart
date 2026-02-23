import 'package:flutter/material.dart';
import 'package:splash_design/1stpage.dart';
import 'package:splash_design/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<bool> isLight = ValueNotifier<bool>(true);

  void _setLight(bool value) {
    isLight.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyAppFirst(isLightNotifier: isLight, onThemeChanged: _setLight),
      home: LoginPage(),
    );
  }
}
