switch_world:
    type: task
    definitions: world_name|default_gamemode|display_name
    script:
    - if <player.world.name> == <[world_name]>:
        - narrate "<red>You're already here."
        - stop
    - if not <world[<[world_name]>].exists>:
        - narrate "<red>World '<[world_name]>' not found! <gray>Report this to the owner."
        - stop
    - flag <player> worlds.<player.world.name>:<map[location=<player.location>;inventory=<player.inventory.list_contents>;gamemode=<player.gamemode>;is_flying=<player.is_flying>]>
    - if <player.has_flag[worlds.<[world_name]>]>:
        - define save <player.flag[worlds.<[world_name]>]>
        - teleport <player> <[save.location]> cause:command
        - adjust <player.inventory> contents:<[save.inventory]>
        - adjust <player> gamemode:<[save.gamemode]>
        - adjust <player> flying:<[save.is_flying]>
    - else:
        - teleport <player> <world[<[world_name]>].spawn_location> cause:command
        - inventory clear d:<player.inventory>
        - adjust <player> gamemode:<[default_gamemode]>
    - narrate "<gray>Welcome to <[display_name]><gray>!"

survival:
    type: command
    name: survival
    description: Play in the survival world
    usage: /survival
    script:
    - run switch_world def:world|survival|<green>survival

creative:
    type: command
    name: creative
    description: Build in the creative world
    usage: /creative
    script:
    - run switch_world def:creative|creative|<aqua>creative
