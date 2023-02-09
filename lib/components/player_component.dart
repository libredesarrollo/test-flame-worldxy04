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
  Vector2 mapSize;
  Vector2 posPlayer;

  PlayerComponent(
      {required this.mapSize, required this.game, required this.posPlayer})
      : super() {
    debugMode = true;
    position = posPlayer;
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

    body = RectangleHitbox(
        size: Vector2(spriteSheetWidth - 60, spriteSheetHeight - 40),
        position: Vector2(30, 20))
      ..collisionType = CollisionType.active;
    add(body);

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is WaterComponent || other is ObjectComponent) {
      if (objectCollitionId == -1) {
        // objectCollition = true;
        // primera colision
        playerCollisionDirection = playerDirection;
        objectCollitionId = other.position.x;
        print(
            'primera colision: ${playerCollisionDirection} ${playerCollisionDirectionTwo} ${playerCollisionDirectionTwo} ${objectCollitionId} ${objectCollitionTwoId}');
      } else if (objectCollitionTwoId == -1 &&
          objectCollitionId != other.position.x) {
        // segunda colision
        objectCollitionTwoId = other.position.x;
        playerCollisionDirectionTwo = playerDirection;
        print(
            'segunda colision: ${playerCollisionDirection} ${playerCollisionDirectionTwo} ${playerCollisionDirectionTwo} ${objectCollitionId} ${objectCollitionTwoId}');
      }
    }

    super.onCollision(points, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is WaterComponent || other is ObjectComponent) {
      if (objectCollitionId == other.position.x) {
        // se fue la primera colision
        playerCollisionDirection =
            playerCollisionDirectionTwo; // la colision dos es la uno ahora
        objectCollitionId = objectCollitionTwoId;
        // limpiamos la segunda colision
        objectCollitionTwoId = -1;
        playerCollisionDirectionTwo = null;
        print(
            '***se fue la primera colision: ${playerCollisionDirection} ${playerCollisionDirectionTwo} ${playerCollisionDirectionTwo} ${objectCollitionId} ${objectCollitionTwoId}');
      } else if (objectCollitionTwoId == other.position.x) {
        // se fue la segunda colision
        playerCollisionDirectionTwo = null;
        objectCollitionTwoId = -1;
        print(
            '***se fue la segunda colision: ${playerCollisionDirection} ${playerCollisionDirectionTwo} ${playerCollisionDirectionTwo} ${objectCollitionId} ${objectCollitionTwoId}');
      }
    }

    super.onCollisionEnd(other);
  }

  // else {
  //   if (objectCollitionId != -1) {
  //   } else {
  //     // solo hay una colision, restablecemos todo
  //     playerCollisionDirectionTwo = null;
  //     playerCollisionDirection = null;
  //     objectCollition = false;
  //     print(
  //         '***solo hay una colision, restablecemos todo: ${playerCollisionDirection} ${playerCollisionDirectionTwo} ${playerCollisionDirectionTwo} ${objectCollitionId} ${objectCollitionTwoId}');
  //   }
  // }

  // @override
  // void onCollisionEnd(PositionComponent other) {
  //   if (other is WaterComponent || other is ObjectComponent) {
  //     if (objectCollitionId == other.position.x) {
  //       // se fue la segunda colision
  //       playerCollisionDirectionTwo = null;
  //       objectCollitionId = -1;
  //       print(
  //           '***se fue la segunda colision: ${playerCollisionDirection} ${playerCollisionDirectionTwo} ${playerCollisionDirectionTwo} ${objectCollitionId} ${objectCollitionTwoId}');
  //     }
  //     else {
  //       if (objectCollitionId != -1) {
  //         // se fue la primera colision
  //         playerCollisionDirectionTwo = playerCollisionDirection;
  //         objectCollitionId = -1;
  //         print(
  //             '***se fue la primera colision: ${playerCollisionDirection} ${playerCollisionDirectionTwo} ${playerCollisionDirectionTwo} ${objectCollitionId} ${objectCollitionTwoId}');
  //       } else {
  //         // solo hay una colision, restablecemos todo
  //         playerCollisionDirectionTwo = null;
  //         playerCollisionDirection = null;
  //         objectCollition = false;
  //         print(
  //             '***solo hay una colision, restablecemos todo: ${playerCollisionDirection} ${playerCollisionDirectionTwo} ${playerCollisionDirectionTwo} ${objectCollitionId} ${objectCollitionTwoId}');
  //       }
  //     }
  //   }

  //   super.onCollisionEnd(other);
  // }

  void reset({bool dead = false}) {
    animation = idleAnimation;
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
        //print('idle');

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
    // if (playerDirection == playerCollisionDirection) {
    // if (playerCollisionDirection.contains(playerDirection)) {
    //   return;
    // }

    // if (playerCollisionDirection.isNotEmpty) {
    //   return;
    // }

    if (!(playerCollisionDirection == playerDirection ||
        playerCollisionDirectionTwo == playerDirection)) {
      switch (movementType) {
        case MovementType.walkingright:
        case MovementType.runright:
          // if (playerCollisionDirection.isNotEmpty &&
          //     playerCollisionDirection[0] == PlayerDirection.right) {
          // if (playerCollisionDirection.isNotEmpty) {
          // if (playerCollisionDirection[0] != PlayerDirection.right) {
          //   position.add(Vector2(delta * speed, 0));
          // }
          // } else {
          //   position.add(Vector2(delta * speed, 0));
          // }

          if (position.x < mapSize.x - size.x) {
            position.add(Vector2(delta * speed, 0));
          }

          break;
        case MovementType.walkingleft:
        case MovementType.runleft:
          // if (playerCollisionDirection.isNotEmpty &&
          //     playerCollisionDirection[0] == PlayerDirection.left) {
          //   // if (playerCollisionDirection[0] != PlayerDirection.left) {
          //   //   position.add(Vector2(delta * -speed, 0));
          //   // }
          // } else {
          //   position.add(Vector2(delta * -speed, 0));
          // }
          if (position.x > 0) {
            position.add(Vector2(delta * -speed, 0));
          }
          break;
        case MovementType.walkingup:
        case MovementType.runup:
          // if (playerCollisionDirection.isNotEmpty &&
          //     playerCollisionDirection[0] == PlayerDirection.up) {
          //   // if (playerCollisionDirection[0] != PlayerDirection.up) {
          //   //   position.add(Vector2(0, delta * -speed));
          //   // }
          // } else {
          //   position.add(Vector2(0, delta * -speed));
          // }
          if (position.y > 0) {
            position.add(Vector2(0, delta * -speed));
          }
          break;
        case MovementType.walkingdown:
        case MovementType.rundown:
          // if (playerCollisionDirection.isNotEmpty &&
          //     playerCollisionDirection[0] == PlayerDirection.down) {
          //   // if (playerCollisionDirection[0] != PlayerDirection.down) {
          //   //   position.add(Vector2(0, delta * speed));
          //   // }
          // } else {
          //   position.add(Vector2(0, delta * speed));
          // }
          if (position.y < mapSize.y - size.y) {
            position.add(Vector2(0, delta * speed));
          }
          break;
        default:
          break;
      }
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
