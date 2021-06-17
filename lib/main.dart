// ignore: import_of_legacy_library_into_null_safe

import 'package:dino_run/widgets/gameover_menu.dart';
import 'package:dino_run/widgets/hud_game.dart';
import 'package:dino_run/widgets/pause_menu.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myGame = MyGame();
    return MaterialApp(
      home: Scaffold(
        body: GameWidget<MyGame>(
          game: myGame,
          overlayBuilderMap: {
            'HudGame': (ctx, game) {
              return HudGame(game: game);
            },
            'PauseMenu': (ctx, game) {
              return PauseMenu(game: game);
            },
            'GameOverMenu': (ctx, game) {
              return GameOverMenu(game: game);
            }
          },
        ),
      ),
      theme: ThemeData(
        fontFamily: 'Audiowide-Regular',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
