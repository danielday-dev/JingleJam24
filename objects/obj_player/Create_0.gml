event_inherited();
x = 1;
y = 1;
GameState_discoverTile(x, y);

combatAvailableMoves = [
	getCombatMove(CombatMoves.Default_Light),
	getCombatMove(CombatMoves.Default_Heavy),
];