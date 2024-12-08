dx = x;
dy = y;

entityHealth = entityHealthMax;
entityTurnTimer = irandom(10);

combatAvailableMoves = [
	getCombatMove(CombatMoves.Sword_Wood),
	getCombatMove(CombatMoves.Axe_Wood),
];
plannedMove = irandom(array_length(combatAvailableMoves) - 1);
lastMove = -1;

combatAvailableMagic = [];

entityScale = 1.0;
renderScale = 1.0;

baseDrawPos = new Vector2(0, 0);
baseDrawOffset = new Vector2(0, 0);