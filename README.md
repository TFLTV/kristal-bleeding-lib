# Kristal Bleeds
"Kristal Bleeds" is a library for Kristal and is a recreation of KuroSora's "Deltarune but Kris is Bleeding" mod for Deltarune.

## How to use
There are multiple variables that can be set to customize the settings.

-----
### `Battle.bleed_timer`
`Battle.bleed_timer` is how much time there has been since bleed damage. If `Battle.bleed_timer` is above the supposed bleed time, it will reset to `0` and trigger bleed damage.

-----
### `Battle.bleeders`/`Game.bleeders`
`Battle.bleeders`, or `Game.bleeders` will set the party-members who bleed. `Battle.bleeders` takes priority over `Game.bleeders`, so if `Battle.bleeders` is set, `Game.bleeders` will not take affect. `Battle.bleeders` can either be party indexes (that will be used in `Battle.party[index]`) or `PartyBattler` objects. `Game.bleeders`, however, can only be party indexes. Defaults to the first `PartyBattler` in `Battle.party`

-----
### `Battle.do_bleed`/`Game.do_bleed`
`Battle.do_bleed`, or `Game.do_bleed` controls if the bleeders bleed and if graze heal is on. `Battle.do_bleed` takes priority over `Game.do_bleed`. Defaults to `true`.

-----
### `Battle.bleed_amount`/`Game.bleed_amount`
`Battle.bleed_amount`, or `Game.bleed_amount` controls the amount of damage the bleeders will take per bleed. `Battle.bleed_amount` takes priority over `Game.do_bleed`. Defaults to `1`.

-----
### `Bullet.graze_heal`/`Wave.graze_heal`/`EnemyBattler.graze_heal`/`Soul.graze_heal`/`Battle.graze_heal`/`Game.graze_heal`
`Bullet.graze_heal`, `Wave.graze_heal`, `EnemyBattler.graze_heal`, `Soul.graze_heal`, `Battle.graze_heal`, or `Game.graze_heal` sets the amount of health the bleeders will regenerate everytime the soul grazes a bullet. `Bullet.graze_heal` takes priority over `Wave.graze_heal`. `Wave.graze_heal` takes priority over `EnemyBattler.graze_heal`. `EnemyBattler.graze_heal` takes priority over `Soul.graze_heal`. `Soul.graze_heal` takes priority over `Battle.graze_heal`. `Battle.graze_heal` takes priority over `Game.graze_heal`. Defaults to `10 + Utils.random(0,2,1)`

-----
### `Battle.moving_bleed_time`/`Game.moving_bleed_time`
`Battle.moving_bleed_time`, or `Game.moving_bleed_time` controls how much time it takes for every bleed damage to trigger while the soul is moving. `Battle.moving_bleed_time` takes priority over `Game.moving_bleed_time`. Defaults to `4/30`.

-----
### `Battle.idle_bleed_time`/`Game.idle_bleed_time`
`Battle.idle_bleed_time`, or `Game.idle_bleed_time` controls how much time it takes for every bleed damage to trigger while the soul is not moving. `Battle.idle_bleed_time` takes priority over `Game.idle_bleed_time`. Defaults to `2/30`.
