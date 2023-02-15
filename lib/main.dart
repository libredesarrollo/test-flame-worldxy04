import 'package:flame/collisions.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:worldxy04/components/player_component.dart';
import 'package:worldxy04/components/zombie_component.dart';
import 'package:worldxy04/helpers/enemy/movements.dart';
import 'package:worldxy04/maps/tile_map_component.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late PlayerComponent player;

  @override
  Future<void>? onLoad() {
    var background = TileMapComponent();
    add(background);

    background.loaded.then(
      (value) {
        player = PlayerComponent(
            mapSize: background.tiledMap.size,
            game: this,
            posPlayer: background.posPlayer);
        add(player);
        camera.followComponent(player,
            worldBounds: Rect.fromLTRB(
                0, 0, background.tiledMap.size.x, background.tiledMap.size.y));

        // map 1
        enemiesMap1.forEach((e) => add(ZombieComponent(
            mapSize: background.tiledMap.size,
            typeEnemyMovement: e.typeEnemyMovement,
            movementTypes: e.movementEnemies)
          ..position = Vector2.all(50)));
      },
    );

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
