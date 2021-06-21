import 'package:dino_run/game/constats.dart';
import 'package:dino_run/game/store_manager.dart';
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
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 4, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(Icons.pause, color: Colors.white, size: 30.0),
              onPressed: () {
                pauseGame();
              }),
          Row(
            children: [
              ValueListenableBuilder(
                valueListenable: game.dino!.coins!,
                builder: (context, int value, child) {
                  return Row(
                    children: [
                      Container(
                        child: Image.asset('assets/images/coin/Gold_1.png',
                            width: 25),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(value.toString(),
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                    ],
                  );
                },
              ),
              SizedBox(
                width: 10,
              ),
              ValueListenableBuilder(
                  valueListenable: game.dino!.life!,
                  builder: (context, int value, child) {
                    final list = <Widget>[];

                    for (int i = 0;
                        i < StoreManager.instance.totalLifes!;
                        ++i) {
                      list.add(Icon(
                          i < value ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 30.0));
                    }

                    return Row(children: list);
                  })
            ],
          ),
        ],
      ),
    );
  }

  void pauseGame() {
    game.pauseGame();
  }
}
