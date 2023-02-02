import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class WaterComponent extends PositionComponent {
  WaterComponent({required size, required position})
      : super(size: size, position: position) {
    debugMode = true;
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }
}
