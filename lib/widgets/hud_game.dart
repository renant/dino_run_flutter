import 'package:flutter/material.dart';

import 'package:dino_run/game/game.dart';

class HudGame extends StatelessWidget {
  final MyGame game;

  const HudGame({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(Icons.pause, color: Colors.white, size: 30.0),
            onPressed: () {
              pauseGame();
            }),
        ValueListenableBuilder(
            valueListenable: game.dino!.life!,
            builder: (context, int value, child) {
              final list = <Widget>[];

              for (int i = 0; i < 5; ++i) {
                list.add(Icon(
                    i < value ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 30.0));
              }

              return Row(children: list);
            }),
      ],
    );
  }

  void pauseGame() {
    game.pauseGame();
  }
}
