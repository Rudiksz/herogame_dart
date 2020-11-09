# Hero Game

Once upon a time there was a great hero, called Orderus, with some strengths and weaknesses, as all heroes have.

## Technical details
The game has two modes: local and remote.
* The **local** mode is completely offline and can be used without internet. The game engine is implemented in Dart (current repository).
* The **remote** mode uses a remote server as backend, acting as a UI only. Currently Android and Windows are supported. On Android, remote mode works only with properly signed ssl connections.

## Configuration for the local engine

* **Characters**
    - name
    - description
    - skills
    - stats: Health, Strength, Defence, Speed, Luck - an array of the form [min, max]

* **Monsters**
    - same as characters

* **Skills**
    - **type:** `attack` skills are applied when the player is attacking, `defence` skills while defending
    - **target:** `owner` or `opponent`; which player is the effect applied to
    - **duration:** the effect of `temporary` skills applies only to the current round, while `permanent` skills' effects apply for the remainder of the battle
    - **stats:** the character stat it applies to. The special value `damage` is applied to the damage calculated after applying all other skills. It's `temporary` by nature.
    - **fractionalModifier:** multiplier applied to `stat`.
    - **valueModifier:** this value is added to `stat`. Can be negative or positive.
    - New value equation: (`value` * `fractionalModifier`) + `valueModifier`

## Game Mechanics
* Player selects a character he or she wishes to play
* Before each battle the player stats are reset to a random value between the character's stat range and a random monster is choosen, also with random stats within their range.
* Battle consists of `battle rounds` with one attacker and one defender.
* The player with the greater `speed` and `luck` starts the first round. If both speed and luck are the same, the first player is choosen randomly. 
* Monsters attack automatically, including if they are the first attacker (ambush)
* The battle ends when one player's `health` reaches 0, or at 40 rounds (20 full turns).
* The player with the most `health` health is declared the winner.
* The actions a human player can take are `Attack`, `Quickfight`, `Flee`, `Continue`
    - `Attack` - performs one attack round on the opponents. If the opponents is a `monster`, it will counterattack (creating a second battle round)
    - `Quickfight` - the battle is resolved automatically
    - `Flee` - battle is completed instantly. No more attacks can be performed.
    - `Continue` - when a battle is complete (either through natural means, or by fleeing), the player can start a new battle