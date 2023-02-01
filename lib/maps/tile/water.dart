import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Water extends PositionComponent {
  Water({required size, required position})
      : super(size: size, position: position) {
    debugMode = true;
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }
}
