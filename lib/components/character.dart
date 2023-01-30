import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum MovementType {
  walkingright,
  walkingleft,
  walkingtop,
  walkingbottom,
  runright,
  runleft,
  runtop,
  runbottom,
  idle
}

class Character extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks {
  int animationIndex = 0;

  MovementType movementType = MovementType.idle;

  double speed = 40;
  bool isMoving = false;

  final double spriteSheetWidth = 128, spriteSheetHeight = 128;

  bool inGround = false,
      right = true,
      collisionXRight = false,
      collisionXLeft = false;

  late SpriteAnimation deadAnimation,
      idleAnimation,
      leftAnimation,
      rightAnimation,
      topAnimation,
      bottomAnimation;

  late RectangleHitbox body;
}
