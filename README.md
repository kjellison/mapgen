# mapgen
more rogue-like map generation practice with pathfinding for creatures

Practicing the use of different algorithms for games.

keys:
Select Tile: Left Mouse
DeSelect: Right Mouse
Reset: 'r'
Iterate Cellular Automota: 'c'
Flood selected area: 'f'
Clear flood select: 'w'
Remove all non flooded floor: 'q' --gives a fully traversible area (no islands)
Auto Generate: 's'
Add Creature at selected tile: 't'
A* first creature targeting creature: 'o'
Move creature(s): Arrow Keys -- this currently moves all creatures on the map
Diagonal movements: 'l', 'k', '.', ','

Area starts with noise generated floor
Press 'c' to iterate CA  to make a dungeon map. The more times you iterate the smoother it gets but eventually it stops changing.
Select a floor tile in an area you want to keep, press 'f' to flood fill that area and 'q' to remove anything not flooded.
Select a tile and press 't' to add a creature then repeat the process somewhere else.
Press 'o' to have the first creature "hunt" the second creature.
You can move the creature(s) around with arrow keys.

The map is generated with a basic cellular automata algorithm but then marching squares is used to give the edges some "smoothness"
Pathfinding uses A*
