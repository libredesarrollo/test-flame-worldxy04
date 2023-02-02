import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class ObjectComponent extends PositionComponent {
  ObjectComponent({required size, required position})
      : super(size: size, position: position) {
    debugMode = true;
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }
}
