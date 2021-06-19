import 'dart:math';
import 'dart:ui';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import 'enemy.dart';
import 'game.dart';

class EnemyManager extends Component with HasGameRef<MyGame> {
  Random? _random;
  Timer? _timer;
  int _spawnLevel = 0;

  EnemyManager() {
    _random = Random();
    _timer = Timer(4, repeat: true, callback: () async {
      spawnRandomEnemy();
    });
  }

  spawnRandomEnemy() {
    final randomNumber = _random!.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values[randomNumber];
    final newEnemy = new Enemy(randomEnemyType, gameRef.images);
    gameRef.add(newEnemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer!.start();
  }

  // @override
  // void render(Canvas c) {}

  @override
  void update(double dt) {
    _timer!.update(dt);

    var newSpawnLevel = (gameRef.score ~/ 250);
    if (_spawnLevel < newSpawnLevel) {
      _spawnLevel = newSpawnLevel;

      var newWaitTime = (4 / (1 + (0.1 * _spawnLevel)));

      _timer!.stop();
      _timer = Timer(newWaitTime, repeat: true, callback: () async {
        spawnRandomEnemy();
      });
      _timer!.start();
    }
  }

  void reset() {
    _spawnLevel = 0;
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });
    _timer!.start();
  }
}
