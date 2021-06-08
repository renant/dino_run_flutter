import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class MyGame extends BaseGame {
  @override
  Future<void> onLoad() async {
    await images.load('dino.png');

    final spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: images.fromCache('dino.png'), columns: 24, rows: 1);

    SpriteComponent player = SpriteComponent(
        sprite: spriteSheet.getSpriteById(1),
        size: Vector2(64, 64),
        position: Vector2(100, 100));

    add(player);
  }
}
