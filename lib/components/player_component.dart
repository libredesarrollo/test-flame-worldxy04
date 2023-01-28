import 'package:flutter/services.dart';

import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';

import 'package:worldxy04/components/character.dart';
import 'package:worldxy04/utils/create_animation_by_limit.dart';
import 'package:worldxy04/main.dart';

class PlayerComponent extends Character {
  MyGame game;

  PlayerComponent({required this.game}) : super() {
    anchor = Anchor.center;
    debugMode = true;
  }

  int count = 0;

  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('player.png');
    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // init animation
    // deadAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 0, yInit: 0, step: 8, sizeX: 5, stepTime: .08, loop: false);
    // idleAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 0, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 3, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    // jumpAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 3, yInit: 0, step: 12, sizeX: 5, stepTime: .02, loop: false);
    // runAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 5, yInit: 0, step: 8, sizeX: 5, stepTime: .08);
    // walkAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 6, yInit: 2, step: 10, sizeX: 5, stepTime: .08);
    // walkSlowAnimation = spriteSheet.createAnimationByLimit(
    //     xInit: 6, yInit: 2, step: 10, sizeX: 5, stepTime: .32);
    // end animation

    reset();

    body = RectangleHitbox()..collisionType = CollisionType.active;

    add(body);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    print(other.toString() + " " + points.first[0].toString());
    // if (other is ScreenHitbox) {
    //   if (points.first[0] <= 0.0) {
    //     // left
    //     collisionXLeft = true;
    //   } else if (points.first[0] >= mapSize.x - size.x) {
    //     // left
    //     collisionXRight = true;
    //   }
    // }

    super.onCollision(points, other);
  }

  void reset({bool dead = false}) {
    animation = idleAnimation;
    position =
        Vector2(spriteSheetWidth / 4 + 200, 100 - spriteSheetHeight + 200);
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    movementType = MovementType.idle;
  }
}
