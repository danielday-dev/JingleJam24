function CombatMove(_timeCost) constructor {
	timeCost = _timeCost;
}

enum CombatMoves {
	Default_Light,
	Default_Heavy,
};

function getCombatMove(_enum) {
	switch (_enum) {
		case CombatMoves.Default_Light: return new CombatMove(2);
		case CombatMoves.Default_Heavy: return new CombatMove(5);
	}
	return undefined;
}