import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'constats.dart';

enum EnemyType { AngryPigGreen, AngryPigRed, Bat, Rino }

class EnemyData {
  final String image;
  final int columns;
  final int rows;
  final int textureHeight;
  final int textureWidth;
  final int speed;
  final bool canFly;

  EnemyData({
    required this.image,
    required this.columns,
    required this.rows,
    required this.textureHeight,
    required this.textureWidth,
    this.speed = 250,
    this.canFly = false,
  });
}

class Enemy extends SpriteAnimationComponent {
  EnemyData? _myData;
  static Random _random = Random();

  static Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.AngryPigGreen: EnemyData(
      columns: 16,
      rows: 1,
      image: angryPigGreenPng,
      textureHeight: 30,
      textureWidth: 36,
    ),
    EnemyType.AngryPigRed: EnemyData(
      columns: 12,
      rows: 1,
      image: angryPigRedPng,
      textureHeight: 30,
      textureWidth: 36,
    ),
    EnemyType.Bat: EnemyData(
        columns: 7,
        rows: 1,
        image: batPng,
        textureHeight: 30,
        textureWidth: 46,
        speed: 300,
        canFly: true),
    EnemyType.Rino: EnemyData(
        columns: 6,
        rows: 1,
        image: rinoPng,
        textureHeight: 34,
        textureWidth: 52,
        speed: 350),
  };

  Enemy(EnemyType type, Images images) {
    _myData = _enemyDetails[type];

    final spriteSheet = new SpriteSheet.fromColumnsAndRows(
      image: images.fromCache(_myData!.image),
      columns: _myData!.columns,
      rows: _myData!.rows,
    );

    this.animation = spriteSheet.createAnimation(
        row: 0, from: 0, to: (_myData!.columns - 1), stepTime: 0.1);

    this.anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x -= _myData!.speed * dt;
  }

  var isRender = false;

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);

    if (isRender) {
      return;
    }

    double scaledFactor =
        (canvasSize[0] / numberOfTilesAlongWidth) / _myData!.textureWidth;

    this.height = _myData!.textureHeight * scaledFactor;
    this.width = _myData!.textureWidth * scaledFactor;

    this.x = canvasSize[0] + this.width;
    this.y = canvasSize[1] - groundHeight - (this.height / 2);

    if (_myData!.canFly && _random.nextBool()) {
      this.y -= this.height;
    }

    isRender = true;
  }
}
