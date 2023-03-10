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
  // List<PlayerDirection> playerCollisionDirection = [];
  PlayerDirection? playerCollisionDirection = null;
  PlayerDirection? playerCollisionDirectionTwo = null;

  double speed = 120;
  // bool objectCollition = false;
  double objectCollitionId = -1;
  double objectCollitionTwoId = -1;

  double spriteSheetWidth = 128, spriteSheetHeight = 128;

  late SpriteAnimation idleAnimation,
      leftAnimation,
      rightAnimation,
      upAnimation,
      downAnimation;

  late RectangleHitbox body;
}
