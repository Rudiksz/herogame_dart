# Hero Game

Once upon a time there was a great hero, called Orderus, with some strengths and weaknesses, as all heroes have.

## Technical details
The game has two modes: local and remote.
* The **local** mode is completely offline and can be used without internet. The game engine is implemented in Dart (current repository).
* The **remote** mode uses a remote server as backend, acting as a UI only. Currently Android and Windows are supported. On Android, remote mode works only with properly signed ssl connections.

## Configuration for the local engine

* Characters
    - name
    - description
    - skills
    - stats: Health, Strength, Defence, Speed, Luck - an array of the form [min, max]

* Monsters
    - same as characters

* **Skills**
    - **type:** `attack` skills are applied when the player is attacking, `defence` skills while defending
    - **target:** `owner` or `opponent`; which player is the effect applied to
    - **duration:** the effect of `temporary` skills applies only to the current round, while `permanent` skills' effects apply for the remainder of the battle
    - **stats:** the character stat it applies to. The special value `damage` is applied to the damage calculated after applying all other skills. It's `temporary` by nature.
    - **fractionalModifier:** multiplier applied to `stat`.
    - **valueModifier:** this value is added to `stat`. Can be negative or positive.
    - New value equation: (`value` * `fractionalModifier`) + `valueModifier`