import 'package:dino_run/game/store_manager.dart';
import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart' hide Image;
// import 'package:flutter/widgets.dart';

import 'audio_manager.dart';
import 'constats.dart';

enum DinoType { Blue, Green, Red, Yellow }

class DinoData {
  final String image;

  DinoData({
    required this.image,
  });
}

class Dino extends SpriteAnimationComponent {
  DinoData? _myData;

  static Map<DinoType, DinoData> _dinoDetails = {
    DinoType.Blue: DinoData(
      image: dinoBluePng,
    ),
    DinoType.Red: DinoData(
      image: dinoRedPng,
    ),
    DinoType.Yellow: DinoData(
      image: dinoYellowPng,
    ),
    DinoType.Green: DinoData(
      image: dinoGreenPng,
    )
  };

  SpriteAnimation? _runAnimation;
  SpriteAnimation? _hitAnimation;
  Timer? _timer;
  bool _isHit = false;

  double speedY = 0.0;
  double yMax = 0.0;

  ValueNotifier<int>? life;
  ValueNotifier<int>? coins;

  Dino(DinoType type, Images images) {
    _myData = _dinoDetails[type];
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: images.fromCache(_myData!.image), columns: 24, rows: 1);

    _runAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 10);

    _hitAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 14, to: 16);

    this.animation = _runAnimation;
    _timer = Timer(1, callback: () {
      run();
    });

    this.anchor = Anchor.center;

    life = ValueNotifier(StoreManager.instance.totalLifes!);
    coins = ValueNotifier(0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // final velocity = initial velocity + gravity * time;
    // v = u + ut

    this.speedY += GRAVITY * dt;

    //distace = speed * time;
    // d = s * t
    this.y += this.speedY * dt;

    if (isOnGround()) {
      this.y = this.yMax;
      this.speedY = 0.0;
    }

    _timer!.update(dt);
  }

  bool isOnGround() {
    return (this.y >= this.yMax);
  }

  var isRender = false;

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    if (isRender) {
      return;
    }

    this.height = this.width = canvasSize[0] / numberOfTilesAlongWidth;
    this.x = this.width;
    this.y =
        canvasSize[1] - groundHeight - (this.height / 2) + dinoTopBottomSpacing;
    this.yMax = this.y;

    isRender = true;
  }

  void run() {
    _isHit = false;
    this.animation = _runAnimation;
  }

  void hit() {
    if (!_isHit) {
      this.animation = _hitAnimation;
      life!.value -= 1;
      AudioManager.instance.playSfx('hurt7.wav');
      _timer!.start();
      _isHit = true;
    }
  }

  void getCoin() {
    AudioManager.instance.playSfx("coin.mp3");
    coins!.value += 1;
  }

  void jump() {
    if (isOnGround()) {
      this.speedY = -500;
      AudioManager.instance.playSfx('jump14.wav');
    }
  }
}
