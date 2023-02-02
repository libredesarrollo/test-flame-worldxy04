import 'package:flutter/services.dart';

import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';

import 'package:worldxy04/components/character.dart';
import 'package:worldxy04/maps/tile/object_component.dart';
import 'package:worldxy04/maps/tile/water_component.dart';
import 'package:worldxy04/utils/create_animation_by_limit.dart';

import 'package:worldxy04/main.dart';

class PlayerComponent extends Character {
  MyGame game;

  PlayerComponent({required this.game}) : super() {
    debugMode = true;
  }

  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('player.png');
    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // init animation
    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 3, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    downAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    leftAnimation = spriteSheet.createAnimationByLimit(
        xInit: 1, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    rightAnimation = spriteSheet.createAnimationByLimit(
        xInit: 2, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    upAnimation = spriteSheet.createAnimationByLimit(
        xInit: 3, yInit: 0, step: 4, sizeX: 8, stepTime: .2);
    // end animation

    reset();

    body = RectangleHitbox()..collisionType = CollisionType.active;
    add(body);
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    //print(other.toString() + " " + points.first[0].toString());

    if (other is WaterComponent || other is ObjectComponent) {
      objectCollition = true;
      playerCollisionDirection = playerDirection;
    }

    super.onCollision(points, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    playerCollisionDirection = null;
    super.onCollisionEnd(other);
  }

  void reset({bool dead = false}) {
    animation = idleAnimation;
    position = Vector2(0, 0);
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    movementType = MovementType.idle;
  }

  @override
  void update(double dt) {
    move(dt);
    super.update(dt);
  }

  void move(double delta) {
    movePlayer(delta);

    switch (movementType) {
      case MovementType.walkingright:
      case MovementType.runright:
        animation = rightAnimation;
        _resetAnimation();

        break;
      case MovementType.walkingleft:
      case MovementType.runleft:
        animation = leftAnimation;
        _resetAnimation();

        break;
      case MovementType.walkingup:
      case MovementType.runup:
        animation = upAnimation;
        _resetAnimation();

        break;
      case MovementType.walkingdown:
      case MovementType.rundown:
        animation = downAnimation;
        _resetAnimation();

        break;

      case MovementType.idle:
        print('idle');

        animation?.loop = false;
        // animation?.loop = false;
        break;
      default:
        break;
    }
  }

  void _resetAnimation() {
    if (!animation!.loop) {
      animation?.loop = true;
      animation?.reset();
    }
  }

  void movePlayer(double delta) {
    if (objectCollition && playerDirection == playerCollisionDirection) {
      return;
    }

    print('moverrrr ${objectCollition} ${playerCollisionDirection}');

    switch (movementType) {
      case MovementType.walkingright:
      case MovementType.runright:
        position.add(Vector2(delta * speed, 0));
        break;
      case MovementType.walkingleft:
      case MovementType.runleft:
        position.add(Vector2(delta * -speed, 0));
        break;
      case MovementType.walkingup:
      case MovementType.runup:
        position.add(Vector2(0, delta * -speed));
        break;
      case MovementType.walkingdown:
      case MovementType.rundown:
        position.add(Vector2(0, delta * speed));
        break;
      default:
        break;
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.isEmpty) {
      movementType = MovementType.idle;
      //   isMoving = false;
      // } else {
      //   isMoving = true;
    }

    // RIGHT
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      playerDirection = PlayerDirection.right;
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
      playerDirection = PlayerDirection.left;
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        // RUN
        movementType = MovementType.runleft;
      } else {
        // WALKING
        movementType = MovementType.walkingleft;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
      playerDirection = PlayerDirection.down;
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        // RUN
        movementType = MovementType.rundown;
      } else {
        // WALKING
        movementType = MovementType.walkingdown;
      }
    } else
    // LEFT
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW)) {
      playerDirection = PlayerDirection.up;
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        // RUN
        movementType = MovementType.runup;
      } else {
        // WALKING
        movementType = MovementType.walkingup;
      }
    }

    return true;
  }
}
