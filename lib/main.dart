// ignore: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ads/ad_state.dart';
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
      await dotenv.load(fileName: ".env");
      await AdState.instance.init();
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
      debugShowCheckedModeBanner: false,
      title: 'Dino Running',
      home: MainMenu(),
      theme: ThemeData(
        fontFamily: 'Audiowide-Regular',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
