import 'dart:math';
import 'dart:ui';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import 'coin.dart';
import 'enemy.dart';
import 'game.dart';

class StateManager extends Component with HasGameRef<MyGame> {
  Random? _random;
  Timer? _timer;
  int _spawnLevel = 0;

  StateManager() {
    _random = Random();
    _timer = Timer(3, repeat: true, callback: () async {
      spawn();
    });
    _timer!.start();
  }

  spawnRandomEnemy() {
    final randomNumber = _random!.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values[randomNumber];
    final newEnemy = new Enemy(randomEnemyType, gameRef.images);
    gameRef.add(newEnemy);
  }

  spawnCoin() {
    final coin = new Coin(gameRef.images);
    gameRef.add(coin);
  }

  spawn() {
    final randonSpawnCoin = _random!.nextInt(5);

    if (randonSpawnCoin == 4) {
      spawnCoin();
    } else {
      spawnRandomEnemy();
    }
  }

  @override
  void onMount() {
    super.onMount();
    _timer!.start();
  }

  @override
  void update(double dt) {
    _timer!.update(dt);

    var newSpawnLevel = (gameRef.score ~/ 500);
    if (_spawnLevel < newSpawnLevel) {
      _spawnLevel = newSpawnLevel;

      var newWaitTime = (3 / (1 + (0.1 * _spawnLevel)));

      _timer!.stop();
      _timer = Timer(newWaitTime, repeat: true, callback: () async {
        spawn();
      });
      _timer!.start();
    }
  }

  void reset() {
    _spawnLevel = 0;
    _timer = Timer(4, repeat: true, callback: () {
      spawn();
    });
    _timer!.start();
  }
}
