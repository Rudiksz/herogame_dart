import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:herogame/config.dart';
import 'package:herogame/main.dart';
import 'package:herogame/models/player.dart';
import 'package:herogame/services/router/router.dart';
import 'package:herogame/views/widgets/card_header.dart';
import 'package:herogame/views/widgets/character_tile.dart';
import 'package:herogame/views/widgets/player_tile.dart';
import 'package:herogame/views/widgets/skill_icon.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:herogame/app.dart';
import 'package:herogame/models/character.dart';
import 'package:herogame/views/widgets/common_screen.dart';
import 'package:herogame/views/widgets/message_box.dart';
import 'package:herogame/views/widgets/progress_indicator.dart';

class CharacterSelector extends StatefulWidget {
  final App app;

  const CharacterSelector({Key key, this.app}) : super(key: key);

  @override
  _CharacterSelectorState createState() => _CharacterSelectorState();
}

class _CharacterSelectorState extends State<CharacterSelector> {
  @override
  void initState() {
    super.initState();

    if (widget.app.backendType == 'remote') {
      loadCharacters();
    } else {
      widget.app.characters = GameConfig.characters.asObservable();
      widget.app.monsters = GameConfig.monsters.asObservable();
      // Also update the selected character, if any
      if (widget.app.character != null) {
        widget.app.character = widget.app.characters.firstWhere(
          (element) => element.id == widget.app.character.id,
          orElse: () => null,
        );
      }
    }
  }

  loadCharacters() async {
    widget.app.busy = true;
    widget.app.error = '';
    try {
      Response response =
          await dio.post(widget.app.backendUrl + '?action=characters&o=json');

      final data = jsonDecode(response.data);

      if ((response?.data == null) || !(data is Map)) {
        throw FormatException('Invalid reposnse');
      }

      final characters = <Character>[];
      for (var row in data['characters'].values) {
        characters.add(Character.fromJson(row));
      }
      widget.app.characters = characters.asObservable();

      final monsters = <Character>[];
      for (var row in data['monsters']) {
        monsters.add(Character.fromJson(row));
      }
      widget.app.monsters = monsters.asObservable();

      // Also update the selected character, if any
      if (widget.app.character != null) {
        widget.app.character = characters.firstWhere(
          (element) => element.id == widget.app.character.id,
          orElse: () => null,
        );
      }
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
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return CommonScaffold(
      widget.app,
      title: Text("Hero Game"),
      onReload: loadCharacters,
      body: SingleChildScrollView(
        child: Center(
          child: Observer(
            builder: (_) {
              if (widget.app.busy)
                return NetworkProgressIndicator(
                  title: 'Loading character classes',
                );

              if (widget.app.error.isNotEmpty)
                return MessageBox(
                  message: widget.app.error,
                  onTap: loadCharacters,
                  type: MessageBox.error,
                );

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 400,
                    child: Observer(builder: (_) {
                      final selected = widget.app.character;
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: widget.app.characters
                            .map((e) => CharacterTile(
                                  widget.app,
                                  e,
                                  selected: e.id == selected?.id,
                                  onSelected: (char) =>
                                      widget.app.character = char,
                                ))
                            .toList(),
                      );
                    }),
                  ),
                  Observer(
                    builder: (_) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: (widget.app.character == null)
                          ? [Text('Select a character to see the stats')]
                          : [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant),
                                margin: EdgeInsets.all(0.0),
                                child: IconTheme(
                                  data: Theme.of(context).iconTheme.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(width: 8),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: widget.app.backendType ==
                                                'remote'
                                            ? Image.network(widget
                                                    .app.backendUrl +
                                                'assets/${widget.app.character.id}.jpg')
                                            : Image.asset(
                                                'assets/${widget.app.character.id}.jpg'),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        widget.app.character.name,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: TextFormField(
                                          onChanged: (v) => widget.app.name = v,
                                          style: TextStyle(
                                            color: Colors.white,
                                            decorationColor: Colors.white,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Choose your name',
                                            fillColor: Colors.blue,
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                ),
                              ),
                              if (width > 600)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: _description()),
                                    SizedBox(width: 8),
                                    SizedBox(
                                      width: 200,
                                      child: _statsBox(context),
                                    ),
                                    SizedBox(width: 8),
                                    SizedBox(
                                      width: 200,
                                      child: _skillsBox(context),
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                )
                              else ...[
                                _description(),
                                SizedBox(height: 8),
                                _statsBox(context),
                                SizedBox(height: 8),
                                _skillsBox(context),
                              ],
                              FloatingActionButton.extended(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  Routes.battle,
                                ),
                                label: Text('Start'),
                              ),
                            ],
                    ),
                  ),
                  SizedBox(height: 8),
                  CardHeader(label: 'Monsters'),
                  SizedBox(
                    height: 400,
                    child: Observer(builder: (_) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: widget.app.monsters
                            .map((e) => PlayerTile(
                                widget.app,
                                Player(
                                  name: e.name,
                                  character: e,
                                  type: PlayerType.monster,
                                ),
                                compact: true))
                            .toList(),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _description() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(builder: (_) {
          return Text(
            widget.app.character.description.replaceFirst(
              '{NAME}',
              widget.app.name.isNotEmpty
                  ? widget.app.name
                  : 'The ${widget.app.character.name}',
            ),
          );
        }),
      );

  _statsBox(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Stats',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
          ...widget.app.character.stats?.entries
                  ?.map((s) => ListTile(
                        title: Text(
                          StatNames[s.key],
                          softWrap: false,
                          overflow: TextOverflow.visible,
                        ),
                        leading: Icon(StatIcons[s.key]),
                        trailing: Text(s.value.join(' - ')),
                        dense: true,
                      ))
                  ?.toList() ??
              [],
        ],
      );

  _skillsBox(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Skills',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
          ...widget.app.character.skills
                  ?.map((skill) => Tooltip(
                        message: skill.description,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                        padding: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(skill.name),
                          leading: SkillIcon(
                            skill,
                            app: widget.app,
                          ),
                          dense: true,
                        ),
                      ))
                  ?.toList() ??
              [],
        ],
      );
}
