spawn_player_hearts:
    type: world
    events:
        on player tries to attack player with:air:
        - if <player.is_sneaking>:
            - determine passively cancelled
            - define between <context.entity.eye_location.sub[<player.eye_location>]>
            - playeffect effect:heart at:<player.eye_location.add[<[between].div[2]>].up[0.5]> offset:0,0,0 quantity:1
