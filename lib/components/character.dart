import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum MovementType {
  walkingright,
  walkingleft,
  runright,
  runleft,
  walkingtop,
  walkingbottom,
  runbottom,
  runtop,
  idle,
}

class Character extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks {
  int animationIndex = 0;

  MovementType movementType = MovementType.idle;

  final double spriteSheetWidth = 128, spriteSheetHeight = 128;

  bool inGround = false,
      right = true,
      collisionXRight = false,
      collisionXLeft = false;

  late SpriteAnimation deadAnimation,
      idleAnimation,
      jumpAnimation,
      runAnimation,
      walkAnimation,
      walkSlowAnimation;

  late RectangleHitbox body;
}
