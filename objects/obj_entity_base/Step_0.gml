dx = (x + 0.5) * TILESCALE;
dy = (y + 0.4) * TILESCALE;

if (plannedMove == -1) 
	plannedMove = irandom(array_length(combatAvailableMoves) - 1);