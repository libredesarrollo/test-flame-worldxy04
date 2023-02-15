import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:worldxy04/components/character.dart';
import 'package:worldxy04/components/enemy_character.dart';
import 'package:worldxy04/helpers/enemy/movements.dart';
import 'package:worldxy04/maps/tile/object_component.dart';
import 'package:worldxy04/maps/tile/water_component.dart';

import 'package:worldxy04/utils/create_animation_by_limit.dart';

import 'dart:math';

class ZombieComponent extends EnemyCharacter {
  Vector2 mapSize;
  double elapsedTime = 0;

  ZombieComponent(
      {required this.mapSize,
      required movementTypes,
      required typeEnemyMovement})
      : super(typeEnemyMovement, movementTypes) {
    debugMode = true;
  }

  @override
  Future<void>? onLoad() async {
    spriteSheetWidth = 32;
    spriteSheetHeight = 64;
    final spriteImage = await Flame.images.load('zombie.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // init animation
    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 3, sizeX: 3, stepTime: .2);
    downAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 3, sizeX: 3, stepTime: .2);
    leftAnimation = spriteSheet.createAnimationByLimit(
        xInit: 1, yInit: 0, step: 3, sizeX: 3, stepTime: .2);
    rightAnimation = spriteSheet.createAnimationByLimit(
        xInit: 2, yInit: 0, step: 3, sizeX: 3, stepTime: .2);
    upAnimation = spriteSheet.createAnimationByLimit(
        xInit: 3, yInit: 0, step: 3, sizeX: 3, stepTime: .2);
    // end animation

    reset();

    body = RectangleHitbox(
        size: Vector2(
          spriteSheetWidth,
          spriteSheetHeight - 30,
        ),
        position: Vector2(0, 30))
      ..collisionType = CollisionType.active;
    add(body);
    return super.onLoad();
  }

  void reset({bool dead = false}) {
    animation = idleAnimation;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    position = Vector2(300, 300);
    movementType = MovementType.idle;
  }

  @override
  void update(double dt) {
    elapsedTime += dt;

    if (elapsedTime > 3.0) {
      changeDirection();
      elapsedTime = 0.0;
    }

    if (playerCollisionDirection != playerDirection) {
      switch (playerDirection) {
        case PlayerDirection.down:
          if (position.y < mapSize.y - size.y) {
            position.y += speed * dt;
          }
          break;
        case PlayerDirection.left:
          if (position.x > 0) {
            position.x -= speed * dt;
          }
          break;
        case PlayerDirection.up:
          if (position.y > 0) {
            position.y -= speed * dt;
          }
          break;
        case PlayerDirection.right:
          if (position.x < mapSize.x - size.x) {
            position.x += speed * dt;
          }
          break;
      }
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is WaterComponent || other is ObjectComponent) {
      // if (playerCollisionDirection == null) {
      //   // ??=
      playerCollisionDirection ??= playerDirection;
      // }
    }

    super.onCollision(points, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is WaterComponent || other is ObjectComponent) {
      playerCollisionDirection = null;
    }

    super.onCollisionEnd(other);
  }
}
