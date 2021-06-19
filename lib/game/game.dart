import 'dart:io';
import 'dart:ui';

import 'package:dino_run/game/audio_manager.dart';
import 'package:dino_run/game/enemy_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import 'audio_manager.dart';
import 'constats.dart';
import 'dino.dart';
import 'enemy.dart';

const double groundHeight = 32;
const double dinoTopBottomSpacing = 10;
const double numberOfTilesAlongWidth = 10;

class MyGame extends BaseGame with TapDetector {
  Dino? dino;
  EnemyManager? enemyManager;
  TextComponent? _scoreText;
  double score = 0;
  double _elapsedTime = 0.0;

  bool _isGameOver = false;
  bool _isGamePaused = false;

  @override
  Future<void> onLoad() async {
    await images.load(dinoPng);
    await images.load(angryPigGreenPng);
    await images.load(angryPigRedPng);
    await images.load(batPng);
    await images.load(rinoPng);

    final parallaxImages = [
      loadParallaxImage('parallax/plx-1.png'),
      loadParallaxImage('parallax/plx-2.png'),
      loadParallaxImage('parallax/plx-3.png'),
      loadParallaxImage('parallax/plx-4.png'),
      loadParallaxImage('parallax/plx-5.png'),
      loadParallaxImage('parallax/plx-6.png', fill: LayerFill.none),
    ];
    final layers = parallaxImages.map((image) async => ParallaxLayer(
        await image,
        velocityMultiplier: Vector2(
            parallaxImages.indexOf(image) == 5
                ? 3.33
                : parallaxImages.indexOf(image) * 1,
            0)));

    final parallaxComponent = ParallaxComponent.fromParallax(
      Parallax(
        await Future.wait(layers),
        baseVelocity: Vector2(60, 0),
      ),
    );
    add(parallaxComponent);

    dino = new Dino(images.fromCache(dinoPng));

    add(dino!);

    enemyManager = new EnemyManager();
    add(enemyManager!);

    overlays.add("HudGame");

    _scoreText = TextComponent(score.toInt().toString(),
        textRenderer: TextPaint(
            config: TextPaintConfig(
          fontFamily: 'Audiowide-Regular',
          color: Colors.white,
        )));

    add(_scoreText!);

    AudioManager.instance.startBgm();
  }

  @override
  void onResize(Vector2 canvasSize) {
    super.onResize(canvasSize);

    _scoreText?.x = (canvasSize[0] / 2) - (_scoreText!.width / 2);
    _scoreText?.y = canvasSize[1] - (canvasSize[1] + _scoreText!.height - 20);
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        pauseGame();
        break;
      case AppLifecycleState.paused:
        pauseGame();
        break;
      case AppLifecycleState.detached:
        pauseGame();
        break;
    }
  }

  void pauseGame() {
    if (_isGameOver) {
      AudioManager.instance.pauseBgm();
      this.pauseEngine();
      this._isGamePaused = true;
      this.overlays.add("PauseMenu");
    }
  }

  @override
  void onTapDown(TapDownInfo event) {
    super.onTapDown(event);

    if (!_isGameOver && !_isGamePaused) {
      dino!.jump();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    _elapsedTime += dt;
    if (_elapsedTime > (1 / 60)) {
      score += 1;
      _scoreText!.text = score.toInt().toString();
    }

    components.whereType<Enemy>().forEach((enemy) {
      if (dino!.distance(enemy) < 30) {
        dino!.hit();
      }
    });

    if (dino!.life!.value <= 0) {
      gameOver();
    }
  }

  void gameOver() {
    _isGameOver = true;
    AudioManager.instance.stopBgm();
    this.pauseEngine();
    this.overlays.add('GameOverMenu');
  }

  void resetGame() {
    score = 0;
    dino!.run();
    dino!.life!.value = 5;
    enemyManager!.reset();
    overlays.remove("GameOverMenu");
    resumeEngine();
    _isGameOver = false;
    AudioManager.instance.resumeBgm();

    components.whereType<Enemy>().forEach((enemy) => {remove(enemy)});
  }

  void resumeGame() {
    _isGamePaused = false;
    AudioManager.instance.resumeBgm();
    resumeEngine();
    overlays.remove("PauseMenu");
  }

  @override
  void onDetach() {
    AudioManager.instance.stopBgm();
    super.onDetach();
  }
}
