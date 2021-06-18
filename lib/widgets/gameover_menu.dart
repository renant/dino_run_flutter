import 'package:dino_run/game/enemy.dart';
import 'package:dino_run/screens/main_menu.dart';
import 'package:flutter/material.dart';

import 'package:dino_run/game/game.dart';

class GameOverMenu extends StatelessWidget {
  final MyGame game;

  const GameOverMenu({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Game Over',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              SizedBox(height: 10),
              Text('Your Score was ${game.score.toInt()}',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.replay_outlined),
                        SizedBox(width: 10),
                        Text(
                          'Retry',
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ],
                    ),
                    onPressed: () {
                      resetGame();
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey)),
                    child: Text(
                      'Main Menu',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MainMenu(),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void resetGame() {
    this.game.score = 0;
    this.game.dino!.run();
    this.game.dino!.life!.value = 5;
    this.game.enemyManager!.reset();
    game.overlays.remove("GameOverMenu");
    game.resumeEngine();
    this.game.dino!.run();

    this
        .game
        .components
        .whereType<Enemy>()
        .forEach((enemy) => {this.game.remove(enemy)});
  }
}
