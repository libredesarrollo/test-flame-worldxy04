import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:worldxy04/components/character.dart';
import 'package:worldxy04/components/enemy_character.dart';

import 'package:worldxy04/utils/create_animation_by_limit.dart';

import 'dart:math';

class ZombieComponent extends EnemyCharacter {
  double elapsedTime = 0;
  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('player.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // init animation
    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 3, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    downAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    leftAnimation = spriteSheet.createAnimationByLimit(
        xInit: 1, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    rightAnimation = spriteSheet.createAnimationByLimit(
        xInit: 2, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    upAnimation = spriteSheet.createAnimationByLimit(
        xInit: 3, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    // end animation

    reset();

    body = RectangleHitbox(
        size: Vector2(spriteSheetWidth - 60, spriteSheetHeight - 40),
        position: Vector2(30, 20))
      ..collisionType = CollisionType.active;
    add(body);
    return super.onLoad();
  }

  void reset({bool dead = false}) {
    animation = idleAnimation;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    movementType = MovementType.idle;
  }

  @override
  void update(double dt) {
    elapsedTime += dt;

    if (elapsedTime > 3.0) {
      changeDirection();
      elapsedTime = 0.0;
    }

    switch (playerDirection) {
      case PlayerDirection.down:
        position.y += speed * dt;
        break;
      case PlayerDirection.left:
        position.x -= speed * dt;
        break;
      case PlayerDirection.up:
        position.y -= speed * dt;
        break;
      case PlayerDirection.right:
        position.x += speed * dt;
        break;
    }

    super.update(dt);
  }
}
