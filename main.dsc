greet:
    type: world
    events:
        after player joins flagged:!greeted:
        - narrate <empty>
        - narrate "<gray>Welcome to the <blue><bold>Α<white><bold>Σ<blue><bold>Κ <yellow><bold>Ξ Chapter <reset><gray>Minecraft server!"
        - narrate <empty>
        - narrate "<gray>To play in survival, run <green>/survival"
        - narrate "<gray>To build in creative, run <aqua>/creative"
        - narrate <empty>
        - narrate "<gray>This server is managed by <red>acikek <gray>(Skye)."
        - flag <player> greeted
