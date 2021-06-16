// ignore: import_of_legacy_library_into_null_safe

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
            'PauseMenu': (ctx, game) {
              return IconButton(
                  icon: Icon(Icons.pause, color: Colors.white, size: 30.0),
                  onPressed: () {
                    print("pause");
                  });
            },
          },
        ),
      ),
    );
  }
}
