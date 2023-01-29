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
    bottomAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    leftAnimation = spriteSheet.createAnimationByLimit(
        xInit: 1, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    rightAnimation = spriteSheet.createAnimationByLimit(
        xInit: 2, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    topAnimation = spriteSheet.createAnimationByLimit(
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
    move(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    print(other.toString() + " " + points.first[0].toString());

    super.onCollision(points, other);
  }

  void reset({bool dead = false}) {
    animation = idleAnimation;
    position =
        Vector2(spriteSheetWidth / 4 + 200, 100 - spriteSheetHeight + 200);
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    movementType = MovementType.idle;
  }

  void move(double delta) {
    movePlayer(delta);

    switch (movementType) {
      case MovementType.walkingright:
      case MovementType.runright:
        animation = rightAnimation;
        break;
      case MovementType.walkingleft:
      case MovementType.runleft:
        animation = leftAnimation;
        break;
      case MovementType.walkingtop:
      case MovementType.runtop:
        animation = topAnimation;
        break;
      case MovementType.walkingbottom:
      case MovementType.runbottom:
        animation = bottomAnimation;
        break;
      default:
        animation = idleAnimation;
        break;
    }
  }

  void movePlayer(double delta) {
    switch (movementType) {
      case MovementType.walkingright:
      case MovementType.runright:
        position.add(Vector2(delta * speed, 0));
        break;
      case MovementType.walkingleft:
      case MovementType.runleft:
        position.add(Vector2(delta * -speed, 0));
        break;
      case MovementType.walkingtop:
      case MovementType.runtop:
        position.add(Vector2(0, delta * -speed));
        break;
      case MovementType.walkingbottom:
      case MovementType.runbottom:
        position.add(Vector2(0, delta * speed));
        break;
      default:
        break;
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.isEmpty) {
      isMoving = false;
    }

    // RIGHT
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        // RUN
        movementType = MovementType.runright;
      } else {
        // WALKING
        movementType = MovementType.walkingright;
      }
    } else
    // LEFT
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        // RUN
        movementType = MovementType.runleft;
      } else {
        // WALKING
        movementType = MovementType.walkingleft;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        // RUN
        movementType = MovementType.runbottom;
      } else {
        // WALKING
        movementType = MovementType.walkingbottom;
      }
    } else
    // LEFT
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW)) {
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        // RUN
        movementType = MovementType.runtop;
      } else {
        // WALKING
        movementType = MovementType.walkingtop;
      }
    }

    return true;
  }
}
