# LSDebug
I'mmmmm foobar!

A lua script for [Bizhawk](https://github.com/TASEmulators/BizHawk) that superimposes a community-made "debug menu" onto LSD: Dream Emulator.

# Guide
![An example of the debug menu in action. The player is in Kyoto, on Day 1, and their graph position is (2, 0).](https://github.com/xen-0sd/LSDebug/blob/main/example1.png)
![The same example, notated to show what each part of the menu displays. Some indicators only appear when the thing they monitor is active.](https://github.com/xen-0sd/LSDebug/blob/main/example2.png)

# Controls
LSDebug can not only read from the game, it can mess with it too:
- ↕ | Change the dreamer's X position
- ↔ | Change the dreamer's Y position
- SPACE/CTRL | Change the dreamer's Z position
- I/O | Change the "factor" (how much each button press will change a value)
- Q/E | Change the current day (only takes effect when entering a new field)

# Credits
## Sievaxx
- Initial attempts to display the graph in real time
- Inspiration for a full-on debug menu

## Xen
- Concept
- Project lead
- All code not credited elsewhere

## Hgs.
- Figuring out how the graph works
- Graph display code
- Many invaluable contributions to the LSD science community

## LaytonLoztew
- Entity display code
