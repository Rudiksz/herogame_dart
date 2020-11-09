// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Battle on BattleBase, Store {
  Computed<Player> _$currentAttackerComputed;

  @override
  Player get currentAttacker => (_$currentAttackerComputed ??= Computed<Player>(
          () => super.currentAttacker,
          name: 'BattleBase.currentAttacker'))
      .value;
  Computed<Player> _$currentDefenderComputed;

  @override
  Player get currentDefender => (_$currentDefenderComputed ??= Computed<Player>(
          () => super.currentDefender,
          name: 'BattleBase.currentDefender'))
      .value;
  Computed<BattleRound> _$lastRoundComputed;

  @override
  BattleRound get lastRound =>
      (_$lastRoundComputed ??= Computed<BattleRound>(() => super.lastRound,
              name: 'BattleBase.lastRound'))
          .value;
  Computed<int> _$roundNumberComputed;

  @override
  int get roundNumber =>
      (_$roundNumberComputed ??= Computed<int>(() => super.roundNumber,
              name: 'BattleBase.roundNumber'))
          .value;
  Computed<Player> _$winnerComputed;

  @override
  Player get winner => (_$winnerComputed ??=
          Computed<Player>(() => super.winner, name: 'BattleBase.winner'))
      .value;

  final _$player1Atom = Atom(name: 'BattleBase.player1');

  @override
  Player get player1 {
    _$player1Atom.reportRead();
    return super.player1;
  }

  @override
  set player1(Player value) {
    _$player1Atom.reportWrite(value, super.player1, () {
      super.player1 = value;
    });
  }

  final _$player2Atom = Atom(name: 'BattleBase.player2');

  @override
  Player get player2 {
    _$player2Atom.reportRead();
    return super.player2;
  }

  @override
  set player2(Player value) {
    _$player2Atom.reportWrite(value, super.player2, () {
      super.player2 = value;
    });
  }

  final _$currentAtom = Atom(name: 'BattleBase.current');

  @override
  Player get current {
    _$currentAtom.reportRead();
    return super.current;
  }

  @override
  set current(Player value) {
    _$currentAtom.reportWrite(value, super.current, () {
      super.current = value;
    });
  }

  final _$statusAtom = Atom(name: 'BattleBase.status');

  @override
  BattleStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(BattleStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$roundsAtom = Atom(name: 'BattleBase.rounds');

  @override
  ObservableList<BattleRound> get rounds {
    _$roundsAtom.reportRead();
    return super.rounds;
  }

  @override
  set rounds(ObservableList<BattleRound> value) {
    _$roundsAtom.reportWrite(value, super.rounds, () {
      super.rounds = value;
    });
  }

  final _$descriptionAtom = Atom(name: 'BattleBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$autoAtom = Atom(name: 'BattleBase.auto');

  @override
  bool get auto {
    _$autoAtom.reportRead();
    return super.auto;
  }

  @override
  set auto(bool value) {
    _$autoAtom.reportWrite(value, super.auto, () {
      super.auto = value;
    });
  }

  final _$autoFightAsyncAction = AsyncAction('BattleBase.autoFight');

  @override
  Future autoFight() {
    return _$autoFightAsyncAction.run(() => super.autoFight());
  }

  final _$BattleBaseActionController = ActionController(name: 'BattleBase');

  @override
  void attack() {
    final _$actionInfo =
        _$BattleBaseActionController.startAction(name: 'BattleBase.attack');
    try {
      return super.attack();
    } finally {
      _$BattleBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic flee() {
    final _$actionInfo =
        _$BattleBaseActionController.startAction(name: 'BattleBase.flee');
    try {
      return super.flee();
    } finally {
      _$BattleBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
player1: ${player1},
player2: ${player2},
current: ${current},
status: ${status},
rounds: ${rounds},
description: ${description},
auto: ${auto},
currentAttacker: ${currentAttacker},
currentDefender: ${currentDefender},
lastRound: ${lastRound},
roundNumber: ${roundNumber},
winner: ${winner}
    ''';
  }
}

mixin _$BattleRound on BattleRoundBase, Store {
  final _$attackerAtom = Atom(name: 'BattleRoundBase.attacker');

  @override
  Player get attacker {
    _$attackerAtom.reportRead();
    return super.attacker;
  }

  @override
  set attacker(Player value) {
    _$attackerAtom.reportWrite(value, super.attacker, () {
      super.attacker = value;
    });
  }

  final _$defenderAtom = Atom(name: 'BattleRoundBase.defender');

  @override
  Player get defender {
    _$defenderAtom.reportRead();
    return super.defender;
  }

  @override
  set defender(Player value) {
    _$defenderAtom.reportWrite(value, super.defender, () {
      super.defender = value;
    });
  }

  final _$statusAtom = Atom(name: 'BattleRoundBase.status');

  @override
  BattleRoundStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(BattleRoundStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$damageAtom = Atom(name: 'BattleRoundBase.damage');

  @override
  int get damage {
    _$damageAtom.reportRead();
    return super.damage;
  }

  @override
  set damage(int value) {
    _$damageAtom.reportWrite(value, super.damage, () {
      super.damage = value;
    });
  }

  final _$skillModifiersAtom = Atom(name: 'BattleRoundBase.skillModifiers');

  @override
  List<SkillModifier> get skillModifiers {
    _$skillModifiersAtom.reportRead();
    return super.skillModifiers;
  }

  @override
  set skillModifiers(List<SkillModifier> value) {
    _$skillModifiersAtom.reportWrite(value, super.skillModifiers, () {
      super.skillModifiers = value;
    });
  }

  final _$BattleRoundBaseActionController =
      ActionController(name: 'BattleRoundBase');

  @override
  BattleRoundStatus attack() {
    final _$actionInfo = _$BattleRoundBaseActionController.startAction(
        name: 'BattleRoundBase.attack');
    try {
      return super.attack();
    } finally {
      _$BattleRoundBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
attacker: ${attacker},
defender: ${defender},
status: ${status},
damage: ${damage},
skillModifiers: ${skillModifiers}
    ''';
  }
}
