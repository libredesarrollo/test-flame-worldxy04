import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame_tiled/flame_tiled.dart';

import 'package:tiled/tiled.dart';
import 'package:worldxy04/maps/tile/object_component.dart';
import 'package:worldxy04/maps/tile/water_component.dart';

class TileMapComponent extends PositionComponent {
  late TiledComponent tiledMap;
  late Vector2 posPlayer;

  @override
  Future<void>? onLoad() async {
    tiledMap = await TiledComponent.load('map.tmx', Vector2.all(48));
    add(tiledMap);

    final objWater = tiledMap.tileMap.getLayer<ObjectGroup>("water_object");

    for (final obj in objWater!.objects) {
      add(WaterComponent(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y)));
    }
    final objObs = tiledMap.tileMap.getLayer<ObjectGroup>("obstacles_object");

    for (final obj in objObs!.objects) {
      add(ObjectComponent(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y)));
    }

    final objPlayer = tiledMap.tileMap.getLayer<ObjectGroup>("player_object");
    posPlayer = Vector2(objPlayer!.objects[0].x, objPlayer.objects[0].y);

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
