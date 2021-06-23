import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'constats.dart';

class Coin extends SpriteAnimationComponent {
  SpriteAnimation? _coinAnimation;
  static Random _random = Random();
  var isRender = false;
  final _speed = 250;

  Coin(Images images) {
    final coinSprites = coinImages
        .map((coinImage) => new Sprite(images.fromCache(coinImage)))
        .toList();

    _coinAnimation = SpriteAnimation.spriteList(coinSprites, stepTime: 0.1);

    this.animation = _coinAnimation;
    this.anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x -= _speed * dt;
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);

    if (isRender) {
      return;
    }

    this.width = 30;
    this.height = 30;

    this.x = canvasSize[0] + this.width;
    this.y = canvasSize[1] - groundHeight - (this.height / 2);

    if (_random.nextBool()) {
      this.y -= groundHeight + _random.nextInt((this.height * 3).toInt());
    }

    isRender = true;
  }
}
