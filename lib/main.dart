// ignore: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'game/audio_manager.dart';
import 'game/store_manager.dart';
import 'screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }
  }

  await AudioManager.instance.init();
  await StoreManager.instance.init();

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
