import 'package:flutter/material.dart';

import 'package:dino_run/game/game.dart';

class PauseMenu extends StatelessWidget {
  final MyGame game;

  const PauseMenu({
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
              Text('Paused',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              IconButton(
                icon: Icon(Icons.play_arrow_sharp, size: 30),
                color: Colors.white,
                onPressed: () {
                  resumeGame();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void resumeGame() {
    game.resumeEngine();
    game.overlays.remove("PauseMenu");
  }
}
