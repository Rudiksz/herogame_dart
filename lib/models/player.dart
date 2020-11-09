import 'dart:math';

import 'package:herogame/models/character.dart';
import 'package:mobx/mobx.dart';

part 'player.g.dart';

class Player = PlayerBase with _$Player;

abstract class PlayerBase with Store {
  PlayerBase({this.name, this.character, this.type, this.stats}) {
    if (stats == null) resetStats();
  }

  @observable
  String name;

  @observable
  Character character;

  @observable
  PlayerType type = PlayerType.human;

  @observable
  ObservableMap<CharacterStat, int> stats;

  resetStats() {
    stats = <CharacterStat, int>{}.asObservable();

    final rand = Random();
    character.stats.forEach((key, value) {
      var min = value[0] ?? 50;
      var max = value[1] ?? 100;

      if (min > max) {
        final temp = max;
        max = min;
        min = temp;
      }

      final val = min == max ? min : min + rand.nextInt(max - min + 1);
      stats[key] = val;
    });
  }
}

enum PlayerType { human, monster }
