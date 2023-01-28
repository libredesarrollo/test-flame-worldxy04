import 'package:flame/collisions.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:worldxy04/components/player_component.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  double elapsedTime = 0.0;
  int colisionMeteors = 0;
  late PlayerComponent player;

  @override
  Future<void>? onLoad() {
    player = PlayerComponent(game: this);
    add(player);

    add(ScreenHitbox());

    //return super.onLoad();
  }

  @override
  void update(double dt) {
    elapsedTime += dt;
    super.update(dt);
  }

  @override
  Color backgroundColor() {
    super.backgroundColor();
    return Colors.purple;
  }
}

void main() {
  runApp(GameWidget(
    game: MyGame(),
  ));
}
