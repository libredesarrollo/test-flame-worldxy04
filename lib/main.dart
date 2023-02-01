import 'package:flame/collisions.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:worldxy04/components/player_component.dart';
import 'package:worldxy04/maps/tile_map_component.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late PlayerComponent player;

  @override
  Future<void>? onLoad() {
    var background = TileMapComponent();
    add(background);

    player = PlayerComponent(game: this);
    add(player);

    add(ScreenHitbox());

    //return super.onLoad();
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
