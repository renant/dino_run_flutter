import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';

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
  double speedJumpBase = 0.0;
  double yMax = 0.0;

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

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    this.height = this.width = canvasSize[0] / numberOfTilesAlongWidth;
    this.x = this.width;
    this.y =
        canvasSize[1] - groundHeight - (this.height / 2) + dinoTopBottomSpacing;
    this.yMax = this.y;
    this.speedJumpBase = (canvasSize[0] / 2);
  }

  void run() {
    _isHit = false;
    this.animation = _runAnimation;
  }

  void hit() {
    if (!_isHit) {
      this.animation = _hitAnimation;
      _timer!.start();
      _isHit = true;
    }
  }

  void jump() {
    if (isOnGround()) {
      this.speedY = -speedJumpBase;
    }
  }
}
