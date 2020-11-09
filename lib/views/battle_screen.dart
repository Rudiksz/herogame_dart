import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:herogame/app.dart';
import 'package:herogame/config.dart';
import 'package:herogame/main.dart';
import 'package:herogame/models/battle.dart';
import 'package:herogame/models/character.dart';
import 'package:herogame/models/player.dart';
import 'package:herogame/views/widgets/common_screen.dart';
import 'package:herogame/views/widgets/message_box.dart';
import 'package:herogame/views/widgets/player_tile.dart';
import 'package:herogame/views/widgets/progress_indicator.dart';

class BattleScreen extends StatefulWidget {
  final App app;

  const BattleScreen({Key key, this.app}) : super(key: key);

  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  @override
  void initState() {
    super.initState();
    createBattle();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return CommonScaffold(
      widget.app,
      title: Text("Hero Game: Battle"),
      onReload: createBattle,
      body: Center(
        child: Observer(builder: (_) {
          if (widget.app.busy)
            return NetworkProgressIndicator(
              title: 'Contacting server',
            );

          if (widget.app.error.isNotEmpty)
            return MessageBox(
              message: widget.app.error,
              onTap: widget.app.lastAction ?? createBattle,
              type: MessageBox.error,
            );

          if (widget.app.battle == null) {
            return MessageBox(
              message: widget.app.error,
              onTap: widget.app.lastAction ?? createBattle,
              type: MessageBox.error,
            );
          }

          return width > 600 ? buildWideLayout() : buildNarrowLayout();
        }),
      ),
    );
  }

  buildNarrowLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildPlayer1Tile()),
              Expanded(child: buildPlayer2Tile()),
            ],
          ),
          buildBattleDescription(),
          buildWinner(),
          buildBattleRounds(),
        ],
      ),
    );
  }

  buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: buildPlayer1Tile(),
        ),
        Expanded(
          child: Column(
            children: [
              buildBattleDescription(),
              buildWinner(),
              Expanded(
                child: SingleChildScrollView(
                  child: buildBattleRounds(),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: buildPlayer2Tile(),
        ),
      ],
    );
  }

  buildBattleRounds() {
    return Observer(
      builder: (_) {
        int i = widget.app.battle?.rounds?.length ?? 0;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.app.battle.rounds.reversed
              .map((element) => BattleRoundTile(
                    element,
                    index: i--,
                    user: widget.app.user,
                  ))
              .toList(),
        );
      },
    );
  }

  Observer buildWinner() {
    return Observer(
      builder: (_) => AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: widget.app.battle.status == BattleStatus.completed
            ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(RpgAwesome.trophy),
                      SizedBox(width: 8),
                      Text(widget.app.battle.winner.name,
                          style: Theme.of(context).textTheme.headline5),
                    ],
                  ),
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }

  Observer buildBattleDescription() {
    return Observer(
      builder: (_) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.app.battle.description),
        ),
      ),
    );
  }

  buildPlayer2Tile() => Observer(
        builder: (_) => PlayerTile(
          widget.app,
          widget.app.battle.player2,
          onContinue: createBattle,
          status: widget.app.battle.status,
        ),
      );

  buildPlayer1Tile() => Observer(
        builder: (_) => PlayerTile(
          widget.app,
          widget.app.battle.player1,
          onContinue: createBattle,
          status: widget.app.battle.status,
        ),
      );

  void createBattle() async {
    if (widget.app.backendType == 'remote') {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        widget.app.busy = true;
        widget.app.error = '';
        try {
          Response response = await dio.post(widget.app.backendUrl +
              '?action=battle&character=' +
              widget.app.character.id +
              '&o=json');

          final data = jsonDecode(response.data);

          if ((response?.data == null) ||
              !(data is Map) ||
              data['battle'] == null) {
            throw FormatException('Invalid reposnse');
          }

          widget.app.battle =
              Battle.fromJson(widget.app, data['battle'], remote: true);
        } on DioError catch (e) {
          final int code = e.response?.statusCode ?? 500;
          final String message = e.response?.data != null
              ? (e.response?.data["error"] ?? e.message)
              : e.message;
          widget.app.error = "$code, $message";
        } on FormatException catch (e) {
          widget.app.error = e.message;
        }

        widget.app.busy = false;
      });
    } else {
      final monster = GameConfig.monsters[Random().nextInt(
        GameConfig.monsters.length,
      )];

      widget.app.battle = Battle(
        widget.app,
        Player(
          name: widget.app.user,
          character: widget.app.character,
          type: PlayerType.human,
        ),
        Player(
          name: monster.name,
          character: monster,
          type: PlayerType.monster,
        ),
      );
    }
  }
}

class BattleRoundTile extends StatelessWidget {
  const BattleRoundTile(
    this.round, {
    Key key,
    this.index,
    this.user,
  }) : super(key: key);

  final String user;
  final BattleRound round;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: index % 2 == 0 ? Colors.grey[100] : Colors.grey[300],
      child: ExpansionTile(
        title: Text(status),
        children: details,
        tilePadding: EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  String get status {
    if (round.status == BattleRoundStatus.missed) {
      return round.attacker.name == user ? 'You missed' : 'You evaded';
    }

    if (round.status == BattleRoundStatus.completed) {
      return round.attacker.name == user
          ? 'You dealt ${round.damage} damage'
          : 'You took ${round.damage} damage';
    }

    return '';
  }

  List<Widget> get details {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(children: [Text('Round: $index')]),
            Row(children: [Text('Damage dealt: ${round.damage ?? 'none'}')]),
            Row(children: [
              Text(
                'Skills used: ' +
                    (round.skillModifiers.isEmpty
                        ? 'none'
                        : round.skillModifiers.length.toString()),
              )
            ]),
            ...round.skillModifiers
                .map((e) => Column(children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('• ' + e.skill.name),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 32),
                          Text('Owner: ' + e.owner.name),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 32),
                          Text('Target: ' + e.target.name),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 32),
                          Text(
                            'Stat affected: ' + (StatNames[e.skill.stat] ?? ''),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 32),
                          Text('Old value: ' + e.oldValue.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 32),
                          Text('New value: ' + e.newValue.toString()),
                        ],
                      ),
                    ]))
                .toList(),
          ],
        ),
      ),
    ];
  }
}
