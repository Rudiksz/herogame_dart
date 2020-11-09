// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Player on PlayerBase, Store {
  final _$nameAtom = Atom(name: 'PlayerBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$characterAtom = Atom(name: 'PlayerBase.character');

  @override
  Character get character {
    _$characterAtom.reportRead();
    return super.character;
  }

  @override
  set character(Character value) {
    _$characterAtom.reportWrite(value, super.character, () {
      super.character = value;
    });
  }

  final _$typeAtom = Atom(name: 'PlayerBase.type');

  @override
  PlayerType get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(PlayerType value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  final _$statsAtom = Atom(name: 'PlayerBase.stats');

  @override
  ObservableMap<CharacterStat, int> get stats {
    _$statsAtom.reportRead();
    return super.stats;
  }

  @override
  set stats(ObservableMap<CharacterStat, int> value) {
    _$statsAtom.reportWrite(value, super.stats, () {
      super.stats = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
character: ${character},
type: ${type},
stats: ${stats}
    ''';
  }
}
