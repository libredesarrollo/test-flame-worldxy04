import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame_tiled/flame_tiled.dart';

import 'package:tiled/tiled.dart';
import 'package:worldxy04/maps/tile/water.dart';

class TileMapComponent extends PositionComponent {
  late TiledComponent tiledMap;
  //List<Life> lifes = [];

  @override
  Future<void>? onLoad() async {
    tiledMap = await TiledComponent.load('map.tmx', Vector2.all(48));
    add(tiledMap);

    final objWater = tiledMap.tileMap.getLayer<ObjectGroup>("water_object");

    for (final obj in objWater!.objects) {
      add(Water(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y)));
    }
    final objObs = tiledMap.tileMap.getLayer<ObjectGroup>("obstacles_object");

    for (final obj in objObs!.objects) {
      add(Water(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y)));
    }

    return super.onLoad();
  }

  // void addConsumibles() {
  //   final lifeGroup = tiledMap.tileMap.getLayer<ObjectGroup>("consumible_food");

  //   lifes.forEach((l) => l.removeFromParent());

  //   lifes.clear();
  //   for (final obj in lifeGroup!.objects) {
  //     lifes.add(Life(position: Vector2(obj.x, obj.y)));
  //     add(lifes.last);
  //   }
  // }
}