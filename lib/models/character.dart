import 'package:herogame/models/player.dart';

class Character {
  final String id;
  final String name;
  final String description;
  final Map<CharacterStat, List<int>> stats;
  final List<Skill> skills;
  final bool remote;

  const Character({
    this.id,
    this.name,
    this.description,
    this.stats,
    this.skills,
    this.remote = false,
  });

  factory Character.fromJson(Map<String, dynamic> row) {
    return Character(
      id: row['id'],
      name: row['name'] ?? '',
      description: row['description'] ?? '',
      remote: row['remote'] as bool ?? false,
      stats: {
        CharacterStat.health: stat(row['stats'], CharacterStat.health),
        CharacterStat.strength: stat(row['stats'], CharacterStat.strength),
        CharacterStat.defence: stat(row['stats'], CharacterStat.defence),
        CharacterStat.speed: stat(row['stats'], CharacterStat.speed),
        CharacterStat.luck: stat(row['stats'], CharacterStat.luck),
      },
      skills: (row['skills'] as List)
          .map((e) => Skill(
                e['id'],
                e['name'],
                e['description'],
                target: e['target'] == 'owner'
                    ? SkillTarget.owner
                    : SkillTarget.opponent,
                type: e['type'] == 'attack'
                    ? SkillType.attack
                    : SkillType.defence,
                stat: CharacterStat.stat
                    .fromString((e['stat'] as String).toLowerCase()),
                effectDuration: e['effectDuration'] == 'permanent'
                    ? SkillEffectDuration.permanent
                    : SkillEffectDuration.temporary,
                fractionalModifier: e['fractionalModifier'].toDouble(),
                valueModifier: e['valueModifier'] as int,
                chance: e['chance'] as int,
              ))
          .toList(),
    );
  }

  static List<int> stat(stats, key) =>
      (stats[StatNames[key]] as List).cast<int>();

  @override
  String toString() {
    return '{$id, $name, $stats}';
  }
}

// The [stat] value is used to call the fromString method
enum CharacterStat { health, strength, defence, speed, luck, damage, stat }

extension StringExtension on CharacterStat {
  CharacterStat fromString(String str) => CharacterStat.values.firstWhere(
        (e) => e.toString() == 'CharacterStat.' + str,
        orElse: () => CharacterStat.stat,
      );
}

const Map<CharacterStat, String> StatNames = {
  CharacterStat.health: 'Health',
  CharacterStat.strength: 'Strength',
  CharacterStat.defence: 'Defence',
  CharacterStat.speed: 'Speed',
  CharacterStat.luck: 'Luck',
  CharacterStat.damage: 'Damage',
};

class Skill {
  final String id;
  final String name;
  final String description;
  final SkillType type;
  final SkillTarget target;
  final SkillEffectDuration effectDuration;

  final CharacterStat stat;
  final double fractionalModifier;
  final int valueModifier;
  final int chance;

  const Skill(
    this.id,
    this.name,
    this.description, {
    this.stat,
    this.type = SkillType.attack,
    this.target = SkillTarget.owner,
    this.effectDuration = SkillEffectDuration.temporary,
    this.chance,
    this.fractionalModifier = 1,
    this.valueModifier = 0,
  });

  int apply(Player target, {int value}) =>
      ((value ?? target.stats[stat]) * fractionalModifier).toInt() +
      (valueModifier ?? 0);
}

enum SkillType { attack, defence }
enum SkillTarget { owner, opponent }
enum SkillEffectDuration { permanent, temporary }
