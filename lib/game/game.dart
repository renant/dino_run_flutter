import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/parallax.dart';

import 'constats.dart';
import 'dino.dart';
import 'enemy.dart';

const double groundHeight = 32;
const double dinoTopBottomSpacing = 10;
const double numberOfTilesAlongWidth = 10;

class MyGame extends BaseGame with TapDetector {
  Dino? _dino;
  Enemy? _angryPigGreen;

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

    _dino = new Dino(images.fromCache(dinoPng));
    _angryPigGreen = new Enemy(EnemyType.AngryPigRed, images);

    add(_dino!);
    add(_angryPigGreen!);
  }

  @override
  void onResize(Vector2 canvasSize) {
    super.onResize(canvasSize);

    _dino?.setPosition(canvasSize);
    _angryPigGreen?.setPosition(canvasSize);

    // _dino.height = _dino.width = canvasSize[0] / numberOfTilesAlongWidth;
    // _dino.x = _dino.width;
    // _dino.y =
    //     canvasSize[1] - groundHeight - _dino.height + dinoTopBottomSpacing;

    print(canvasSize.toString());
  }

  @override
  void onTapDown(TapDownInfo event) {
    super.onTapDown(event);
    _dino!.jump();
  }
}
