import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum MovementType {
  idle,
  walkingright,
  walkingleft,
  walkingup,
  walkingdown,
  runright,
  runleft,
  runup,
  rundown,
}

enum PlayerDirection { up, right, left, down }

class Character extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks {
  MovementType movementType = MovementType.idle;

  PlayerDirection playerDirection = PlayerDirection.down;
  PlayerDirection? playerCollisionDirection = PlayerDirection.down;

  double speed = 120;
  bool objectCollition = false;

  final double spriteSheetWidth = 128, spriteSheetHeight = 128;

  late SpriteAnimation idleAnimation,
      leftAnimation,
      rightAnimation,
      upAnimation,
      downAnimation;

  late RectangleHitbox body;
}
