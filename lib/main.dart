import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splash_design/firebase_options.dart';
import 'package:splash_design/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<bool> isLight = ValueNotifier<bool>(true);

  void setLight(bool value) {
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
