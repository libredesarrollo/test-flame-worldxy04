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

class Character extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks {
  MovementType movementType = MovementType.idle;

  double speed = 40;
  bool isMoving = false;

  final double spriteSheetWidth = 128, spriteSheetHeight = 128;

  late SpriteAnimation idleAnimation,
      leftAnimation,
      rightAnimation,
      upAnimation,
      downAnimation;

  late RectangleHitbox body;
}
