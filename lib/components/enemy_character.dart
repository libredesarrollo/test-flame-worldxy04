import 'package:worldxy04/components/character.dart';

import 'dart:math';

class EnemyCharacter extends Character {
  void changeDirection() {
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
}
