#@ Multi-World Setup @#
#
# This configuration requires the following worlds:
#   'survival', 'survival_nether', 'survival_the_end', and 'creative'
#
# The 'survival...' worlds are treated as one and the same.
#
# Players can switch between worlds by running '/survival' and '/creative'.
# All relevant gameplay states are stored per-world as player flags.

## TODO: Preserve spawn points
## TODO: Disable nether portals in creative
## TODO: Add switching between adventure and creative (gamemodes) in the creative world

load_creative_world:
    type: world
    events:
        on server prestart:
        - createworld creative

switch_world:
    type: task
    definitions: world_name|default_gamemode|display_name
    script:
    - if <player.world.name.starts_with[<[world_name]>]>:
        - narrate "<red>You're already here."
        - stop
    - if not <world[<[world_name]>].exists>:
        - narrate "<red>World '<[world_name]>' not found! <gray>Report this to the owner."
        - stop
    - flag <player> worlds.<player.world.name.before[_]>:<map[location=<player.location>;inventory=<player.inventory.list_contents>;gamemode=<player.gamemode>;is_flying=<player.is_flying>;enderchest=<player.enderchest.list_contents>]>
    - if <player.has_flag[worlds.<[world_name]>]>:
        - define save <player.flag[worlds.<[world_name]>].as[map]>
        - teleport <player> <[save.location]> cause:command
        - adjust <player.inventory> contents:<[save.inventory]>
        - adjust <player> gamemode:<[save.gamemode]>
        - adjust <player> flying:<[save.is_flying]>
        - adjust <player.enderchest> contents:<[save.enderchest]>
    - else:
        - teleport <player> <world[<[world_name]>].spawn_location> cause:command
        - inventory clear d:<player.inventory>
        - adjust <player> gamemode:<[default_gamemode]>
        - inventory clear d:<player.enderchest>
    - narrate "<gray>Welcome to <[display_name]><gray>!"

survival:
    type: command
    name: survival
    description: Play in the survival world
    usage: /survival
    script:
    - run switch_world def:survival|survival|<green>survival

creative:
    type: command
    name: creative
    description: Build in the creative world
    usage: /creative
    script:
    - run switch_world def:creative|creative|<aqua>creative
