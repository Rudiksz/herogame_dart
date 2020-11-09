import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:herogame/app.dart';
import 'package:herogame/config.dart';
import 'package:herogame/models/battle.dart';
import 'package:herogame/models/character.dart';
import 'package:herogame/models/player.dart';
import 'package:herogame/views/widgets/footer_info.dart';
import 'package:herogame/views/widgets/skill_icon.dart';

class PlayerTile extends StatelessWidget {
  final App app;
  final Player player;
  final BattleStatus status;
  final Function onContinue;

  final bool compact;

  const PlayerTile(
    this.app,
    this.player, {
    Key key,
    this.onContinue,
    this.compact = false,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                player?.name ?? "",
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            SizedBox(
              width: 150,
              height: 200,
              child: app.backendType == 'remote'
                  ? Image.network(
                      app.backendUrl + 'assets/${player.character.id}.jpg')
                  : Image.asset('assets/${player.character.id}.jpg'),
            ),
            _stats(),
            if (player.character.skills?.isNotEmpty ?? false) ...[
              Divider(indent: 20, endIndent: 20),
              _skills(),
            ],
            if (compact)
              IconButton(
                icon: Icon(Icons.info),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(player.character.description,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                  ),
                ),
              ),
            if (!compact && player.type == PlayerType.human) ...[
              Divider(indent: 20, endIndent: 20),
              Row(
                children: [
                  SizedBox(width: 4),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: !app.battle.auto &&
                              app.battle.status != BattleStatus.completed &&
                              app.battle.currentAttacker == player
                          ? app.battle.attack
                          : null,
                      icon: Icon(
                        AttackIcons[player.character.id] ??
                            RpgAwesome.axe_swing,
                      ),
                      label: Text('Attack'),
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  SizedBox(width: 4),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: !app.battle.auto &&
                              app.battle.status != BattleStatus.completed &&
                              app.battle.currentAttacker == player
                          ? app.battle.flee
                          : null,
                      icon: Icon(RpgAwesome.player_teleport),
                      label: Text('Flee'),
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  SizedBox(width: 4),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: !app.battle.auto &&
                              app.battle.status != BattleStatus.completed &&
                              app.battle.currentAttacker == player
                          ? app.battle.autoFight
                          : null,
                      icon: Icon(RpgAwesome.crossed_axes),
                      label: Text('Quickfight'),
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  SizedBox(width: 4),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: app.battle.status == BattleStatus.completed
                          ? onContinue
                          : null,
                      icon: Icon(RpgAwesome.player_dodge),
                      label: Text('Continue'),
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
              SizedBox(height: 4),
            ]
          ],
        ),
      ),
    );
  }

  _stats() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: (player.stats?.entries?.map(
                (e) => FooterInfo(
                  value: e.value.toString(),
                  label: StatNames[e.key],
                  color: Colors.black,
                  iconData: StatIcons[e.key],
                ),
              ) ??
              [])
          .toList(),
    );
  }

  _skills() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: (player.character.skills?.map(
                (e) => FooterInfo(
                  value: '',
                  label: e?.description ?? '',
                  color: Colors.black,
                  icon: SkillIcon(e, app: app),
                ),
              ) ??
              [])
          .toList(),
    );
  }
}
