import 'package:flutter/material.dart';
import 'package:herogame/app.dart';
import 'package:herogame/models/character.dart';

class SkillIcon extends StatelessWidget {
  final App app;
  final Skill skill;
  final double size;

  const SkillIcon(this.skill, {Key key, this.app, this.size = 24})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return app.backendType == 'remote'
        ? Image.network(
            app.backendUrl + 'assets/skill-${skill.id.toLowerCase()}.jpg',
            height: size,
          )
        : Image.asset(
            'assets/skill-${skill.id.toLowerCase()}.jpg',
            height: size,
          );
  }
}
