import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';

const double groundHeight = 32;
const double dinoTopBottomSpacing = 10;
const double numberOfTilesAlongWidth = 10;

class MyGame extends BaseGame {
  SpriteAnimationComponent _dino = new SpriteAnimationComponent();

  @override
  Future<void> onLoad() async {
    await images.load('dino.png');

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
        velocityMultiplier: Vector2(parallaxImages.indexOf(image) * 1, 0)));

    final parallaxComponent = ParallaxComponent.fromParallax(
      Parallax(
        await Future.wait(layers),
        baseVelocity: Vector2(60, 0),
      ),
    );

    final spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: images.fromCache('dino.png'), columns: 24, rows: 1);

    final idleAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 3);

    final runAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 10);

    final kickAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 11, to: 13);

    final hitAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 14, to: 16);

    final sprintAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 17, to: 23);

    _dino = new SpriteAnimationComponent(
      animation: runAnimation,
    );

    add(parallaxComponent);
    add(_dino);
  }

  @override
  void onResize(Vector2 canvasSize) {
    super.onResize(canvasSize);

    _dino.height = _dino.width = canvasSize[0] / numberOfTilesAlongWidth;
    _dino.x = _dino.width;
    _dino.y =
        canvasSize[1] - groundHeight - _dino.height + dinoTopBottomSpacing;

    print(canvasSize.toString());
  }
}
