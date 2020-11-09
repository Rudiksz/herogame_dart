import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:herogame/app.dart';
import 'package:herogame/config.dart';
import 'package:herogame/main.dart';
import 'package:herogame/models/character.dart';
import 'package:herogame/models/player.dart';
import 'package:mobx/mobx.dart';

part 'battle.g.dart';

class Battle = BattleBase with _$Battle;

abstract class BattleBase with Store {
  final App app;
  String id;

  bool remote = false;

  @observable
  Player player1;

  @observable
  Player player2;

  @observable
  Player current;

  @observable
  BattleStatus status = BattleStatus.running;

  @observable
  ObservableList<BattleRound> rounds = <BattleRound>[].asObservable();

  @observable
  String description;

  @observable
  bool auto = false;

  BattleBase(
    this.app,
    this.player1,
    this.player2, {
    this.remote = false,
  }) {
    createDescription();
    if (currentAttacker.type == PlayerType.monster) attack();
  }

  BattleBase.fromJson(this.app, data, {this.remote = false}) {
    id = data['id'];
    description = data['description'];
    status = data['status'] == 'complete'
        ? BattleStatus.completed
        : BattleStatus.running;

    player1 = Player(
      name: data['player1']['name'] as String,
      character: Character.fromJson(data['player1']['character']),
      type: data['player1']['type'] == 'human'
          ? PlayerType.human
          : PlayerType.monster,
      stats: <CharacterStat, int>{
        CharacterStat.health: data['player1']['stats']['Health'],
        CharacterStat.strength: data['player1']['stats']['Strength'],
        CharacterStat.defence: data['player1']['stats']['Defence'],
        CharacterStat.speed: data['player1']['stats']['Speed'],
        CharacterStat.luck: data['player1']['stats']['Luck'],
      }.asObservable(),
    );

    player2 = Player(
      name: data['player2']['name'] as String,
      character: Character.fromJson(data['player2']['character']),
      type: data['player2']['type'] == 'human'
          ? PlayerType.human
          : PlayerType.monster,
      stats: <CharacterStat, int>{
        CharacterStat.health: data['player2']['stats']['Health'],
        CharacterStat.strength: data['player2']['stats']['Strength'],
        CharacterStat.defence: data['player2']['stats']['Defence'],
        CharacterStat.speed: data['player2']['stats']['Speed'],
        CharacterStat.luck: data['player2']['stats']['Luck'],
      }.asObservable(),
    );

    if (data['rounds'] != null) {
      rounds = (data['rounds'] as List)
          .map((e) => BattleRound.fromJson(e, player1, player2))
          .toList()
          .asObservable();
    }
  }

  createDescription() {
    if (player1 == firstPlayer) {
      description =
          'As you walk through the ever-green forests of Emagia, you come accross a ${player2.name}. He seems to be resting in the shade of a large tree';
    } else {
      description =
          'As you walk through the ever-green forests of Emagia, a ${player2.name} ambushes you from behind a large tree.';
    }
  }

  Player get firstPlayer {
    if (player1.stats[CharacterStat.speed] !=
        player2.stats[CharacterStat.speed]) {
      return player1.stats[CharacterStat.speed] >
              player2.stats[CharacterStat.speed]
          ? player1
          : player2;
    }

    if (player1.stats[CharacterStat.luck] !=
        player2.stats[CharacterStat.luck]) {
      return player1.stats[CharacterStat.luck] >
              player2.stats[CharacterStat.luck]
          ? player1
          : player2;
    }

    // If both speed and luck are the same, the player is choosen randomly
    // ... using pure luck :)
    return Random().nextBool() ? player1 : player2;
  }

  @computed
  Player get currentAttacker => lastRound?.defender ?? firstPlayer;

  @computed
  Player get currentDefender =>
      lastRound?.attacker ?? (currentAttacker == player1 ? player2 : player1);

  @computed
  BattleRound get lastRound => rounds.isNotEmpty ? rounds.last : null;

  @computed
  int get roundNumber => rounds.length ~/ 2;

  @computed
  Player get winner =>
      player1.stats[CharacterStat.health] > player2.stats[CharacterStat.health]
          ? player1
          : player2;

  /// Activates the current round, if any
  @action
  void attack() {
    if (status == BattleStatus.completed) return;

    if (!remote) {
      rounds.add(BattleRound(currentAttacker, currentDefender));

      if (isComplete) {
        status = BattleStatus.completed;
        return;
      }

      if (currentAttacker.type == PlayerType.monster) {
        attack();
        if (isComplete) {
          status = BattleStatus.completed;
        }
      }
    } else {
      app.lastAction = attack;
      remoteAction('attack');
    }
  }

  /// Complete the flight
  @action
  autoFight() async {
    if (status == BattleStatus.completed) return;
    if (!remote) {
      auto = true;
      attack();
      await Future.delayed(Duration(milliseconds: 10));
      autoFight();
    } else {
      app.lastAction = autoFight;
      remoteAction('auto');
    }
  }

  remoteAction(String action) async {
    app.busy = true;
    app.error = '';
    try {
      Response response = await dio
          .post(app.backendUrl + '?action=battle.$action&id=$id&o=json');

      final data = jsonDecode(response.data);

      if ((response?.data == null) ||
          !(data is Map) ||
          data['battle'] == null) {
        throw FormatException('Invalid reposnse');
      }

      app.battle = Battle.fromJson(app, data['battle'], remote: true);
    } on DioError catch (e) {
      final int code = e.response?.statusCode ?? 500;
      final String message = e.response?.data != null
          ? (e.response?.data["error"] ?? e.message)
          : e.message;
      app.error = "$code, $message";
    } on FormatException catch (e) {
      app.error = e.message;
    }

    app.busy = false;
  }

  /// Complete the flight
  @action
  flee() => status = BattleStatus.completed;

  bool get isComplete {
    return player1.stats[CharacterStat.health] == 0 ||
        player2.stats[CharacterStat.health] == 0 ||
        rounds.length == GameConfig.battleRoundLimit;
  }
}

class BattleRound = BattleRoundBase with _$BattleRound;

abstract class BattleRoundBase with Store {
  BattleRoundBase(this.attacker, this.defender, {this.status, this.damage}) {
    attack();
  }

  BattleRoundBase.fromJson(data, Player player1, Player player2) {
    attacker = data['attacker']['name'] == player1.name ? player1 : player2;
    defender = data['defender']['name'] == player1.name ? player1 : player2;
    damage = data['damage'] as int;
    status = data['status'] == 'completed'
        ? BattleRoundStatus.completed
        : (data['status'] == 'missed'
            ? BattleRoundStatus.missed
            : BattleRoundStatus.waiting);

    if (data['skillModifiers'] != null) {
      skillModifiers = (data['skillModifiers'] as List).map((e) {
        var skill = attacker.character.skills.firstWhere(
          (element) => element.id == e['skill']['id'],
          orElse: () => null,
        );

        if (skill == null)
          skill = defender.character.skills.firstWhere(
            (element) => element.id == e['skill']['id'],
            orElse: () => null,
          );

        return SkillModifier(
          skill: skill,
          owner: e['owner']['name'] == player1.name ? player1 : player2,
          target: e['target']['name'] == player1.name ? player1 : player2,
          oldValue: e['oldValue'] as int,
          newValue: e['newValue'] as int,
        );
      }).toList();
    }
  }

  @observable
  Player attacker;

  @observable
  Player defender;

  @observable
  BattleRoundStatus status = BattleRoundStatus.waiting;

  @observable
  int damage;

  @observable
  List<SkillModifier> skillModifiers = <SkillModifier>[].asObservable();

  Map<CharacterStat, int> tempAttackerStats, tempDefenderStats;

  @action
  BattleRoundStatus attack() {
    // Create a temporary copy of the player stats
    tempAttackerStats = Map.from(attacker.stats);
    tempDefenderStats = Map.from(defender.stats);

    // 1. Before evading apply all luck modifying skills
    attacker.character.skills
        ?.where(
          (skill) =>
              skill.stat == CharacterStat.luck &&
              skill.type == SkillType.attack,
        )
        ?.forEach((skill) => applySkill(skill, owner: SkillTarget.owner));

    defender.character.skills
        ?.where(
          (skill) =>
              skill.stat == CharacterStat.luck &&
              skill.type == SkillType.defence,
        )
        ?.forEach((skill) => applySkill(skill, owner: SkillTarget.opponent));

    // 2. Check if attack is evaded
    var luck = tempDefenderStats[CharacterStat.luck];
    if (luck != 0 && Random().chance(likelihood: luck)) {
      return status = BattleRoundStatus.missed;
    }

    // 3. Apply stat modifier skills
    attacker.character.skills
        ?.where(
          (skill) =>
              skill.stat != CharacterStat.luck &&
              skill.stat != CharacterStat.damage &&
              skill.type == SkillType.attack,
        )
        ?.forEach(((skill) => applySkill(skill, owner: SkillTarget.owner)));

    defender.character.skills
        ?.where(
          (skill) =>
              skill.stat != CharacterStat.luck &&
              skill.stat != CharacterStat.damage &&
              skill.type == SkillType.defence,
        )
        ?.forEach(((skill) => applySkill(
              skill,
              owner: SkillTarget.opponent,
            )));

    // 4. Calculate damage
    var strength = tempAttackerStats[CharacterStat.strength];
    var defence = tempDefenderStats[CharacterStat.defence];

    damage = max(0, strength - defence);

    // 5. Apply damage modifier skills
    attacker.character.skills
        ?.where(
          (skill) =>
              skill.stat == CharacterStat.damage &&
              skill.type == SkillType.attack,
        )
        ?.forEach((skill) => damage =
            applySkill(skill, owner: SkillTarget.owner, value: damage));

    defender.character.skills
        ?.where(
          (skill) =>
              skill.stat == CharacterStat.damage &&
              skill.type == SkillType.defence,
        )
        ?.forEach((skill) => damage =
            applySkill(skill, owner: SkillTarget.opponent, value: damage));

    // 6. Apply the damage
    defender.stats[CharacterStat.health] =
        max(0, defender.stats[CharacterStat.health] - damage);

    return status = BattleRoundStatus.completed;
  }

  int applySkill(Skill skill, {SkillTarget owner, int value}) {
    if (!Random().chance(likelihood: skill.chance)) {
      return value;
    }

    var target = owner == SkillTarget.owner
        ? (skill.target == SkillTarget.owner ? attacker : defender)
        : (skill.target == SkillTarget.owner ? defender : attacker);

    var targetStats = owner == SkillTarget.owner
        ? (skill.target == SkillTarget.owner
            ? tempAttackerStats
            : tempDefenderStats)
        : (skill.target == SkillTarget.owner
            ? tempDefenderStats
            : tempAttackerStats);

    final oldValue = value ?? targetStats[skill.stat];
    final newValue = skill.apply(target, value: value);

    if (skill.effectDuration == SkillEffectDuration.permanent &&
        skill.stat != CharacterStat.damage) {
      target.stats[skill.stat] = newValue;
    }

    if (value == null) targetStats[skill.stat] = newValue;

    // Log the skill
    skillModifiers.add(SkillModifier(
      skill: skill,
      owner: owner == SkillTarget.owner ? attacker : defender,
      target: target,
      oldValue: oldValue,
      newValue: newValue,
    ));

    return newValue;
  }
}

class SkillModifier {
  final Skill skill;
  final Player owner, target;
  final int oldValue;
  final int newValue;

  SkillModifier({
    this.skill,
    this.owner,
    this.target,
    this.oldValue,
    this.newValue,
  });
}

extension on Random {
  bool chance({int likelihood}) {
    if (likelihood == null) {
      return nextBool();
    }

    if (likelihood > 100 || likelihood < 0) {
      throw RangeError('likelihood accepts values from 0 to 100.');
    }

    return nextDouble() * 100 < likelihood;
  }
}

enum BattleStatus { running, completed }
enum BattleRoundStatus { waiting, missed, completed }
