import 'package:worldxy04/components/character.dart';

enum TypeEnemy { zombie, skeleton }

enum TypeEnemyMovement { random, pattern }

class BehaviorEnemy {
  BehaviorEnemy(
      {this.movementEnemies = const [],
      required this.typeEnemyMovement,
      this.typeEnemy = TypeEnemy.zombie});
  List<PlayerDirection> movementEnemies;
  TypeEnemyMovement typeEnemyMovement;
  TypeEnemy typeEnemy;
}

List<BehaviorEnemy> enemiesMap1 = [
  BehaviorEnemy(movementEnemies: [
    PlayerDirection.down,
    // PlayerDirection.down,
    // PlayerDirection.right,
    // PlayerDirection.up,
    // PlayerDirection.right,
    // PlayerDirection.down,
    // PlayerDirection.right,
    // PlayerDirection.left,
    PlayerDirection.up,
  ], typeEnemyMovement: TypeEnemyMovement.pattern),
  BehaviorEnemy(typeEnemyMovement: TypeEnemyMovement.random),
  BehaviorEnemy(
      movementEnemies: [PlayerDirection.right, PlayerDirection.left],
      typeEnemyMovement: TypeEnemyMovement.pattern)
];
