import 'dart:io';
import 'dart:ui';

import 'package:dino_run/game/audio_manager.dart';
import 'package:dino_run/game/state_manager.dart';
import 'package:dino_run/game/store_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import 'audio_manager.dart';
import 'coin.dart';
import 'constats.dart';
import 'dino.dart';
import 'enemy.dart';

const double groundHeight = 32;
const double dinoTopBottomSpacing = 10;
const double numberOfTilesAlongWidth = 10;

class MyGame extends BaseGame with TapDetector {
  Dino? dino;
  StateManager? stateManager;
  TextComponent? _scoreText;
  Coin? _coinTest;
  double score = 0;
  double _elapsedTime = 0.0;

  bool _isGameOver = false;
  bool _isGamePaused = false;

  @override
  Future<void> onLoad() async {
    await images.load(dinoBluePng);
    await images.load(dinoRedPng);
    await images.load(dinoGreenPng);
    await images.load(dinoYellowPng);
    await images.load(angryPigGreenPng);
    await images.load(angryPigRedPng);
    await images.load(batPng);
    await images.load(rinoPng);

    await Future.forEach(
        coinImages, (String coinImage) async => await images.load(coinImage));

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

    dino = new Dino(StoreManager.instance.selectedDino, images);

    add(dino!);

    stateManager = new StateManager();
    add(stateManager!);

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
    _scoreText?.y = canvasSize[1] - (canvasSize[1] + _scoreText!.height - 50);
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
    if (!_isGameOver) {
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

    //enemy colission
    components.whereType<Enemy>().forEach((enemy) {
      if (dino!.distance(enemy) < 35) {
        dino!.hit();
      }
    });

    //get coin
    components.whereType<Coin>().forEach((coin) {
      if (dino!.distance(coin) < 25) {
        dino!.getCoin();
        remove(coin);
      }
    });

    if (dino!.life!.value <= 0) {
      gameOver();
    }
  }

  void gameOver() {
    StoreManager.instance.setHighScore(score.toInt());
    _isGameOver = true;
    StoreManager.instance.addCoins(dino!.coins!.value);
    AudioManager.instance.stopBgm();
    this.pauseEngine();
    this.overlays.add('GameOverMenu');
  }

  void resetGame() {
    score = 0;
    dino!.run();
    dino!.coins!.value = 0;
    dino!.life!.value = StoreManager.instance.totalLifes!;
    stateManager!.reset();
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
