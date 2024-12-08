function CombatMove(_damage, _timeCost, _weaponIndex) constructor {
	damage = _damage;
	timeCost = _timeCost;
	weaponIndex = _weaponIndex;
}

enum CombatMoves {
	Sword_Wood, Sword_Iron, Sword_Gold, Sword_Temporal,
	Axe_Wood, Axe_Iron, Axe_Gold, Axe_Temporal,
	Dagger_Wood, Dagger_Iron, Dagger_Gold, Dagger_Temporal, 
	Staff_Wood, Staff_Iron, Staff_Gold, Staff_Temporal,
};

function getCombatMove(_enum) {
	switch (_enum) {
		case CombatMoves.Sword_Wood: return new CombatMove(2, 2, 0);
		case CombatMoves.Sword_Iron: return new CombatMove(3, 2, 1);
		case CombatMoves.Sword_Gold: return new CombatMove(5, 3, 2);
		case CombatMoves.Sword_Temporal: return new CombatMove(7, 3, 3);
		
		case CombatMoves.Axe_Wood: return new CombatMove(4, 5, 4);
		case CombatMoves.Axe_Iron: return new CombatMove(6, 6, 5);
		case CombatMoves.Axe_Gold: return new CombatMove(8, 7, 6);
		case CombatMoves.Axe_Temporal: return new CombatMove(10, 7, 7);
		
		case CombatMoves.Dagger_Wood: return new CombatMove(2, 3, 8);
		case CombatMoves.Dagger_Iron: return new CombatMove(2, 2, 9);
		case CombatMoves.Dagger_Gold: return new CombatMove(3, 2, 10);
		case CombatMoves.Dagger_Temporal: return new CombatMove(4, 1, 11);
		
		case CombatMoves.Staff_Wood: return new CombatMove(2, 15, 12);
		case CombatMoves.Staff_Iron: return new CombatMove(3, 20, 13);
		case CombatMoves.Staff_Gold: return new CombatMove(4, 35, 14);
		case CombatMoves.Staff_Temporal: return new CombatMove(5, 45, 15);
	}
	return undefined;
}