import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart' hide Image;
// import 'package:flutter/widgets.dart';

import 'audio_manager.dart';
import 'constats.dart';

class Dino extends SpriteAnimationComponent {
  SpriteAnimation? _idleAnimation;
  SpriteAnimation? _runAnimation;
  SpriteAnimation? _kickAnimation;
  SpriteAnimation? _hitAnimation;
  SpriteAnimation? _sprintAnimation;
  Timer? _timer;
  bool _isHit = false;

  double speedY = 0.0;
  double yMax = 0.0;

  ValueNotifier<int>? life;

  Dino(Image image) {
    final spriteSheet =
        SpriteSheet.fromColumnsAndRows(image: image, columns: 24, rows: 1);

    _idleAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 3);

    _runAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 10);

    _kickAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 11, to: 13);

    _hitAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 14, to: 16);

    _sprintAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 17, to: 23);

    this.animation = _runAnimation;
    _timer = Timer(1, callback: () {
      run();
    });

    this.anchor = Anchor.center;

    life = ValueNotifier(5);
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

  void jump() {
    if (isOnGround()) {
      this.speedY = -500;
      AudioManager.instance.playSfx('jump14.wav');
    }
  }
}
