import 'package:dino_run/game/game.dart';
import 'package:dino_run/widgets/gameover_menu.dart';
import 'package:dino_run/widgets/hud_game.dart';
import 'package:dino_run/widgets/pause_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// This class is responsible for creating an instance of [DinoGame]
/// and returning its widget.
class GamePlay extends StatelessWidget {
  final MyGame myGame = MyGame();

  GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
