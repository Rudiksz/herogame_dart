import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:herogame/models/character.dart';

class GameConfig {
  static const battleRoundLimit = 40;

  static List<Character> characters = [
    Character(
      id: 'barbarian',
      name: 'Barbarian',
      description:
          '''Gray, short hair gently hangs over a full, lived-in face. Piercing hazel eyes, set well within their sockets, watch watchfully over the ships they've sworn to protect for so long.
A moustache and goatee charmingly compliments his eyes and leaves a pleasant memory of his fortunate upbringing.

This is the face of {NAME}, a true mercenary among humans. He stands easily among others, despite his bulky frame.

There's something intriguing about him, perhaps it's a feeling of coldness or perhaps it's simply his composure. But nonetheless, people tend to take pride in knowing him, while trying to avoid him.''',
      stats: {
        CharacterStat.health: [70, 100],
        CharacterStat.strength: [70, 80],
        CharacterStat.defence: [45, 55],
        CharacterStat.speed: [40, 50],
        CharacterStat.luck: [10, 30],
      },
      skills: [
        GameConfig.skills[Skills.shieldBreaker],
        GameConfig.skills[Skills.deadlyStrike],
        GameConfig.skills[Skills.endurance]
      ],
    ),
    Character(
      id: 'rogue',
      name: 'Orderus',
      description:
          '''Chestnut, oily hair tight in a ponytail reveals a bony, gloomy face. Beady green eyes, set wickedly within their sockets, watch readily over the spirits they've befriended for so long.
Fallen debry left a mark reaching from the top of the right cheek, running towards the tip of the nose and ending on her right nostril and leaves a lasting burden of a great reputation.

The is the face of {NAME}, a true challenger among halflings. She stands common among others, despite her skinny frame.

There's something misleading about her, perhaps it's her fortunate past or perhaps it's simply her bravery. But nonetheless, people tend to try to get her to marry their off-spring, while helping her out in any way they can.''',
      stats: {
        CharacterStat.health: [70, 80],
        CharacterStat.strength: [40, 50],
        CharacterStat.defence: [35, 50],
        CharacterStat.speed: [70, 80],
        CharacterStat.luck: [10, 30],
      },
      skills: [
        GameConfig.skills[Skills.rapidStrike],
        GameConfig.skills[Skills.luckyShot],
        GameConfig.skills[Skills.magicShield]
      ],
    ),
    Character(
        id: 'mage',
        name: 'Mage',
        description:
            '''Red, short hair neatly coiffured to reveal a fine, tense face. Big, round blue eyes, set seductively within their sockets, watch longingly over the spirits they've grieved with for so long.
A tattoo of a skull is prominently featured on the side of her left cheekbone and leaves a fascinating memory of redeemed honor.

The is the face of {NAME}, a true warden among humans. She stands big among others, despite her bulky frame.

There's something enigmatic about her, perhaps it's her fortunate past or perhaps it's simply her kindness. But nonetheless, people tend to treat her like family, while learning as much about her as possible.''',
        stats: {
          CharacterStat.health: [60, 80],
          CharacterStat.strength: [30, 40],
          CharacterStat.defence: [40, 50],
          CharacterStat.speed: [60, 70],
          CharacterStat.luck: [60, 80],
        },
        skills: [
          GameConfig.skills[Skills.premonition],
          GameConfig.skills[Skills.arcaneMastery],
          GameConfig.skills[Skills.arcaneShield],
        ]),
    Character(
        id: 'necromancer',
        name: 'Necromancer',
        description:
            '''Blonde, shaggy hair slightly covers a lean, radiant face. Smart gray eyes, set rooted within their sockets, watch energetically over the haven they've been isolated from for so long.
Several moles are spread awkwardly across his forehead and leaves a pleasurable memory of his luck.

This is the face of {NAME} a true pioneer among vampires. He stands awkwardly among others, despite his subtle frame.

There's something alluring about him, perhaps it's his sense of justice or perhaps it's simply his attitude. But nonetheless, people tend to wish to get to know him better, while helping him out in any way they can.''',
        stats: {
          CharacterStat.health: [80, 100],
          CharacterStat.strength: [50, 70],
          CharacterStat.defence: [10, 20],
          CharacterStat.speed: [20, 30],
          CharacterStat.luck: [30, 80],
        },
        skills: [
          GameConfig.skills[Skills.curse],
          GameConfig.skills[Skills.raiseSkeleton],
          GameConfig.skills[Skills.replenish]
        ]),
    Character(
      id: 'rudolf',
      name: 'Rudolf',
      description:
          '''White, straight hair is pulled back to reveal a lean, time-worn face. Beady gray eyes, set wickedly within their sockets, watch cautiously over the children they've become enchancted by for so long.
Tribal marks in the form of a diagonal line across his left eye marks his legacy but, more importantly leaves an agonizing memory of companionship.

This is the face of {NAME}, a true hero among trolls. He stands average among others, despite his muscled frame.

There's something puzzling about him, perhaps it's his attitude or perhaps it's simply his fortunate past. But nonetheless, people tend to stay on his good side, while thinking of ways to become his friend.
''',
      stats: {
        CharacterStat.health: [99, 100],
        CharacterStat.strength: [100, 100],
        CharacterStat.defence: [100, 100],
        CharacterStat.speed: [100, 100],
        CharacterStat.luck: [100, 100],
      },
    ),
  ];

  static const List<Character> monsters = [
    Character(
      id: 'reptilian',
      name: 'Reptilius',
      description:
          '''This bulky, reptilian, demonic monster dwells in tropical climates. It lures its prey, which includes other predators, small creatures, and humans. It attacks with dizzying blows and obscuring fog. It is rumored that they can cast curses on those who injure them.''',
      stats: {
        CharacterStat.health: [60, 90],
        CharacterStat.strength: [60, 90],
        CharacterStat.defence: [30, 50],
        CharacterStat.speed: [50, 70],
        CharacterStat.luck: [25, 40],
      },
    ),
    Character(
      id: 'treehugger',
      name: 'Treehugger',
      description:
          '''This massive draconic beast makes its home in lush valleys. It tracks its prey, which includes magical beasts and mundane beasts. It attacks with fangs, obscuring fog and scorching gas. It dislikes holy icons. They hunt in packs of 4-24. Legend holds that they posses arcane items.''',
      stats: {
        CharacterStat.health: [80, 90],
        CharacterStat.strength: [60, 90],
        CharacterStat.defence: [40, 60],
        CharacterStat.speed: [20, 40],
        CharacterStat.luck: [10, 20],
      },
    ),
    Character(
      id: 'moonhowler',
      name: 'Moonhowler',
      description:
          '''This small mongrel monster can be found in deserts. It attacks with rapid blows and thrown weapons. It can be easily injured with bright light. It is believed that they can be negotiated with, though their demands are unusual.''',
      stats: {
        CharacterStat.health: [60, 70],
        CharacterStat.strength: [40, 50],
        CharacterStat.defence: [30, 40],
        CharacterStat.speed: [50, 70],
        CharacterStat.luck: [40, 60],
      },
    ),
    Character(
      id: 'skeleton',
      name: 'Bonecrusher',
      description:
          '''This small, ethereal, undead monster can be found in abandoned ruins. It leaps upon its prey, which includes mundane beasts and magical beasts. It attacks with spines, piercing shrieks and melee weapons.''',
      stats: {
        CharacterStat.health: [70, 90],
        CharacterStat.strength: [60, 70],
        CharacterStat.defence: [20, 30],
        CharacterStat.speed: [40, 60],
        CharacterStat.luck: [15, 20],
      },
    ),
    Character(
      id: 'dreadmask',
      name: 'Dreadmask',
      description:
          '''This bulky, snake-like, mongrel creature dwells in mountain passages. It stalks its prey, which includes monstrous humanoids, magical beasts, mundane beasts, and other monsters of the same type. It attacks with dizzying blows and ice.''',
      stats: {
        CharacterStat.health: [90, 100],
        CharacterStat.strength: [80, 90],
        CharacterStat.defence: [40, 60],
        CharacterStat.speed: [5, 10],
        CharacterStat.luck: [10, 20],
      },
    ),
  ];

  static const Map<Skills, Skill> skills = const {
    // -- Offensive skills
    Skills.shieldBreaker: const Skill(
      'shieldBreaker',
      'Shield Breaker',
      'You deal a crushing blow to your enemy, permanently reducing their defence.',
      type: SkillType.attack,
      chance: 50,
      stat: CharacterStat.defence,
      valueModifier: -1,
      target: SkillTarget.opponent,
      effectDuration: SkillEffectDuration.permanent,
    ),

    Skills.deadlyStrike: const Skill(
      'deadlyStrike',
      'Deadly Strike',
      'The time spent sharpening your axe paid off. Your attack causes a deep wound in your opponent, reducing their health by 10%',
      type: SkillType.attack,
      chance: 20,
      stat: CharacterStat.health,
      fractionalModifier: .9,
      target: SkillTarget.opponent,
      effectDuration: SkillEffectDuration.permanent,
    ),

    Skills.rapidStrike: const Skill(
      'rapidstrike',
      'Rapid Strike',
      'A moment of hesitation from your enemy allows you to deal an extra blow in a rapid succecion.',
      type: SkillType.attack,
      chance: 10,
      stat: CharacterStat.strength,
      fractionalModifier: 2,
      target: SkillTarget.owner,
      effectDuration: SkillEffectDuration.temporary,
    ),

    Skills.luckyShot: const Skill(
      'luckyShot',
      'Lucky shot',
      'Decades of practice allows you to aim for the weakest spots of your enemies, bypassing their defenses. Robin Hood would be proud of you.',
      type: SkillType.attack,
      chance: 5,
      stat: CharacterStat.defence,
      fractionalModifier: 0,
      target: SkillTarget.opponent,
      effectDuration: SkillEffectDuration.temporary,
    ),

    Skills.premonition: const Skill(
      'premonition',
      'Premonition',
      'As you tap into the arcane energies of the surrounding field to summon a fireball, you catch glimpses of the future. You are more successful evading future attacks.',
      type: SkillType.attack,
      chance: 50,
      stat: CharacterStat.luck,
      valueModifier: 1,
      target: SkillTarget.owner,
      effectDuration: SkillEffectDuration.permanent,
    ),

    Skills.arcaneMastery: const Skill(
      'arcaneMastery',
      'Arcane Mastery',
      'Your mastery of the mystics arts allows you to absorb arcane energy with every spell you cast. Your spells become stronger as you fight.',
      type: SkillType.attack,
      chance: 80,
      stat: CharacterStat.strength,
      valueModifier: 2,
      target: SkillTarget.owner,
      effectDuration: SkillEffectDuration.permanent,
    ),

    Skills.raiseSkeleton: const Skill(
      'raiseSkeleton',
      'Raise Skeleton',
      'Raises a skeleton to fight along your side.  Once raised, skeletons are bound to you for ever. Each skeleton increases your strength.',
      type: SkillType.attack,
      chance: 100,
      stat: CharacterStat.strength,
      valueModifier: 1,
      effectDuration: SkillEffectDuration.permanent,
    ),

    Skills.curse: const Skill(
      'curse',
      'Curse',
      'Curses your foe, causing it to cower in fear. Cursed foes are unable to evade your attack.',
      type: SkillType.attack,
      chance: 50,
      stat: CharacterStat.luck,
      fractionalModifier: 0,
      target: SkillTarget.opponent,
      effectDuration: SkillEffectDuration.temporary,
    ),

    // -- Defensive skills

    Skills.endurance: const Skill(
      'endurance',
      'Endurance',
      'Your strong physique and relentless training gives you an edge in long battles. Your take less damage as the battle goes on.',
      type: SkillType.defence,
      chance: 50,
      stat: CharacterStat.defence,
      valueModifier: 1,
      target: SkillTarget.owner,
      effectDuration: SkillEffectDuration.permanent,
    ),

    Skills.magicShield: const Skill(
      'magicShield',
      'Magic Shield',
      'Absorbs half of the damage you receive.',
      type: SkillType.defence,
      stat: CharacterStat.damage,
      chance: 20,
      fractionalModifier: .5,
      effectDuration: SkillEffectDuration.temporary,
    ),

    Skills.arcaneShield: const Skill(
      'arcaneShield',
      'Arcane Shield',
      'You surround yourself with an arcane force field causing damage to enemies who attack you.',
      type: SkillType.defence,
      stat: CharacterStat.health,
      chance: 100,
      fractionalModifier: .5,
      target: SkillTarget.opponent,
      effectDuration: SkillEffectDuration.permanent,
    ),

    Skills.replenish: const Skill(
      'replenish',
      'Replenish',
      'You control the dead, but you also control the life force. When you take damage your health increases.',
      type: SkillType.defence,
      stat: CharacterStat.health,
      chance: 30,
      valueModifier: 5,
      target: SkillTarget.owner,
      effectDuration: SkillEffectDuration.permanent,
    ),
  };
}

const Map<String, IconData> AttackIcons = {
  'barbarian': RpgAwesome.axe_swing,
  'rogue': RpgAwesome.archer,
  'mage': RpgAwesome.dragon_breath,
  'necromancer': RpgAwesome.flaming_claw,
  'reptilian': RpgAwesome.crab_claw,
  'treehugger': RpgAwesome.croc_sword,
  'moonhowler': RpgAwesome.hammer_drop,
};

const Map<CharacterStat, IconData> StatIcons = {
  CharacterStat.health: RpgAwesome.health,
  CharacterStat.strength: RpgAwesome.axe,
  CharacterStat.defence: RpgAwesome.shield,
  CharacterStat.speed: RpgAwesome.fast_ship,
  CharacterStat.luck: RpgAwesome.gold_bar,
};

const Map<String, IconData> SkillIcons = {
  'arcaneMastery': RpgAwesome.burning_book,
  'premonition': RpgAwesome.bleeding_eye,
  'arcaneShield': RpgAwesome.burning_eye,
  'shieldBreaker': RpgAwesome.broken_shield,
  'deadlyStrike': RpgAwesome.hammer_drop,
  'endurance': RpgAwesome.muscle_up,
  'rapidStrike': RpgAwesome.player_shot,
  'luckyShot': RpgAwesome.supersonic_arrow,
  'magicShield': RpgAwesome.barrier,
  'curse': RpgAwesome.player_despair,
  'raiseSkeleton': RpgAwesome.flaming_claw,
  'replenish': RpgAwesome.player,
};

enum Skills {
  magicShield,
  rapidStrike,
  raiseSkeleton,
  curse,
  shieldBreaker,
  deadlyStrike,
  luckyShot,
  premonition,
  arcaneMastery,
  endurance,
  arcaneShield,
  replenish,
}
