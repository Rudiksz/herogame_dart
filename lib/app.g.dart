// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$App on AppBase, Store {
  Computed<String> _$userComputed;

  @override
  String get user => (_$userComputed ??=
          Computed<String>(() => super.user, name: 'AppBase.user'))
      .value;

  final _$appDocPathAtom = Atom(name: 'AppBase.appDocPath');

  @override
  String get appDocPath {
    _$appDocPathAtom.reportRead();
    return super.appDocPath;
  }

  @override
  set appDocPath(String value) {
    _$appDocPathAtom.reportWrite(value, super.appDocPath, () {
      super.appDocPath = value;
    });
  }

  final _$databaseChangedAtom = Atom(name: 'AppBase.databaseChanged');

  @override
  bool get databaseChanged {
    _$databaseChangedAtom.reportRead();
    return super.databaseChanged;
  }

  @override
  set databaseChanged(bool value) {
    _$databaseChangedAtom.reportWrite(value, super.databaseChanged, () {
      super.databaseChanged = value;
    });
  }

  final _$backendTypeAtom = Atom(name: 'AppBase.backendType');

  @override
  String get backendType {
    _$backendTypeAtom.reportRead();
    return super.backendType;
  }

  @override
  set backendType(String value) {
    _$backendTypeAtom.reportWrite(value, super.backendType, () {
      super.backendType = value;
    });
  }

  final _$backendUrlAtom = Atom(name: 'AppBase.backendUrl');

  @override
  String get backendUrl {
    _$backendUrlAtom.reportRead();
    return super.backendUrl;
  }

  @override
  set backendUrl(String value) {
    _$backendUrlAtom.reportWrite(value, super.backendUrl, () {
      super.backendUrl = value;
    });
  }

  final _$busyAtom = Atom(name: 'AppBase.busy');

  @override
  bool get busy {
    _$busyAtom.reportRead();
    return super.busy;
  }

  @override
  set busy(bool value) {
    _$busyAtom.reportWrite(value, super.busy, () {
      super.busy = value;
    });
  }

  final _$errorAtom = Atom(name: 'AppBase.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$charactersAtom = Atom(name: 'AppBase.characters');

  @override
  ObservableList<Character> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(ObservableList<Character> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  final _$monstersAtom = Atom(name: 'AppBase.monsters');

  @override
  ObservableList<Character> get monsters {
    _$monstersAtom.reportRead();
    return super.monsters;
  }

  @override
  set monsters(ObservableList<Character> value) {
    _$monstersAtom.reportWrite(value, super.monsters, () {
      super.monsters = value;
    });
  }

  final _$characterAtom = Atom(name: 'AppBase.character');

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

  final _$nameAtom = Atom(name: 'AppBase.name');

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

  final _$battleAtom = Atom(name: 'AppBase.battle');

  @override
  Battle get battle {
    _$battleAtom.reportRead();
    return super.battle;
  }

  @override
  set battle(Battle value) {
    _$battleAtom.reportWrite(value, super.battle, () {
      super.battle = value;
    });
  }

  @override
  String toString() {
    return '''
appDocPath: ${appDocPath},
databaseChanged: ${databaseChanged},
backendType: ${backendType},
backendUrl: ${backendUrl},
busy: ${busy},
error: ${error},
characters: ${characters},
monsters: ${monsters},
character: ${character},
name: ${name},
battle: ${battle},
user: ${user}
    ''';
  }
}
