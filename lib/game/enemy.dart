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

  EnemyData({
    required this.image,
    required this.columns,
    required this.rows,
    required this.textureHeight,
    required this.textureWidth,
  });
}

class Enemy extends SpriteAnimationComponent {
  static Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.AngryPigGreen: EnemyData(
      columns: 15,
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
    ),
    EnemyType.Rino: EnemyData(
      columns: 6,
      rows: 1,
      image: rinoPng,
      textureHeight: 34,
      textureWidth: 52,
    ),
  };

  double speed = 200;
  Vector2 canvasSize = Vector2.zero();
  int textureWidth = 0;
  int textureHeight = 0;

  Enemy(EnemyType type, Images images) {
    final enemyData = _enemyDetails[type];

    final spriteSheet = new SpriteSheet.fromColumnsAndRows(
      image: images.fromCache(enemyData!.image),
      columns: enemyData.columns,
      rows: enemyData.rows,
    );

    this.animation = spriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 0, to: enemyData.columns - 1);

    print(spriteSheet.srcSize[0]);
    print(spriteSheet.srcSize[1]);

    textureWidth = enemyData.textureWidth;
    textureHeight = enemyData.textureHeight;
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x -= speed * dt;

    if (this.x < (-this.width)) {
      this.x = this.canvasSize[0] + this.width;
    }
  }

  void setPosition(Vector2 canvasSize) {
    double scaledFactor =
        (canvasSize[0] / numberOfTilesAlongWidth) / textureWidth;

    this.height = textureHeight * scaledFactor;
    this.width = textureWidth * scaledFactor;

    this.x = canvasSize[0] + this.width;
    this.y = canvasSize[1] - groundHeight - this.height;
    this.canvasSize = canvasSize;
  }
}
