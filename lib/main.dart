// ignore: import_of_legacy_library_into_null_safe

import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dino Running',
      home: MainMenu(),
      theme: ThemeData(
        fontFamily: 'Audiowide-Regular',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
