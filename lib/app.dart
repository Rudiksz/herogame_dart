import 'package:herogame/config.dart';
import 'package:herogame/models/battle.dart';
import 'package:herogame/models/character.dart';
import 'package:herogame/services/database/couchbase.dart';
import 'package:couchbase_lite_dart/couchbase_lite_dart.dart';
import 'package:mobx/mobx.dart';

part 'app.g.dart';

class App = AppBase with _$App;

abstract class AppBase with Store {
  AppBase({this.localDB});

  /// Instance of a database to store local data
  /// This will store the logged in users and their access tokens to the backend,
  /// temporary configurations, other ephemeral app state
  Couchbase localDB;

  @observable
  String appDocPath;

  @observable
  ReplicatorStatus replicatorState;

  @observable
  bool databaseChanged = false;

  @observable
  String backendType = 'local';

  @observable
  String backendUrl = 'http://herogame.ddns.net:8000/';

  onReplicatorChanged(dynamic event) =>
      replicatorState = event as ReplicatorStatus;

  @observable
  bool busy = false;

  @observable
  String error = '';

  // -- Game data

  @observable
  ObservableList<Character> characters = GameConfig.characters.asObservable();

  @observable
  ObservableList<Character> monsters = GameConfig.monsters.asObservable();

  @observable
  Character character;

  @observable
  String name = '';

  @computed
  String get user => name.isNotEmpty ? name : (character?.name ?? '');

  @observable
  Battle battle;

  Function lastAction;
}
