import 'package:worldxy04/components/character.dart';

import 'dart:math';

import 'package:worldxy04/helpers/enemy/movements.dart';

class EnemyCharacter extends Character {
  List<PlayerDirection> movementTypes = [];
  TypeEnemyMovement typeEnemyMovement;
  int newDirection = 0;

  EnemyCharacter(this.typeEnemyMovement, this.movementTypes);

  changeDirection() {
    if (typeEnemyMovement == TypeEnemyMovement.random) {
      _changeDirectionRandom();
    } else {
      _changeDirectionPattern();
    }
  }

  void _changeDirectionRandom() {
    Random random = Random();
    int newDirection = random.nextInt(4);

    if (newDirection == 1) {
      animation = downAnimation;
      playerDirection = PlayerDirection.down;
    } else if (newDirection == 1) {
      animation = upAnimation;
      playerDirection = PlayerDirection.up;
    } else if (newDirection == 2) {
      playerDirection = PlayerDirection.left;
      animation = leftAnimation;
    } else if (newDirection == 3) {
      playerDirection = PlayerDirection.right;
      animation = rightAnimation;
    }
  }

  void _changeDirectionPattern() {
    newDirection++;

    if (newDirection >= movementTypes.length) {
      newDirection = 0;
    } 
    
    playerDirection = movementTypes[newDirection];
    print(movementTypes[newDirection]);

    if (playerDirection == PlayerDirection.up) {
      animation = upAnimation;
    } else if (playerDirection == PlayerDirection.down) {
      animation = downAnimation;
    } else if (playerDirection == PlayerDirection.left) {
      animation = leftAnimation;
    } else if (playerDirection == PlayerDirection.right) {
      animation = rightAnimation;
    }
  }
}
