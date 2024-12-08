function CombatMagic(_type) constructor {
	type = _type;
	used = false;
	active = false;
	cost = 1;
	duration = 1;
	
	static isActive = function() {
		return active; //!used &&
	}
	static use = function(_entity) {
		switch (type) {
			case CombatMagics.Combo: {
				// Wa.
				if (used) {
					if (_entity.lastMove != _entity.plannedMove) active = false;
				} else {
					used = true;
				}
				duration++;
			} return;
		}
		
		used = true;
		active = false;
	}
	static replenish = function() {
		used = false;
		active = false;
		duration = 1;
		GameState_consumeTime(cost);
	}
	
	static getDescription = function() {
		switch (type) {
			case CombatMagics.AOE: return "Attacks will target all enemies.";
			case CombatMagics.Repeat2: return "Attacks will hit the target twice.";
			case CombatMagics.RepeatN: return "Attacks will hit the target n times based on how many enemies there are.";
		
			case CombatMagics.TripleDamage: return "Attacks will deal 3x damage.";
			case CombatMagics.Combo: return "Repeating the same attack multipliers damage by combo length [Active upon broken combo].";
		
			case CombatMagics.MoveTimeAdditional: return "Attack time is added to the attack damage.";
		
			case CombatMagics.TimerDigitAdditional: return "The final digit of the timer is added to the attack damage.";
			case CombatMagics.TimerDigitIsFour: return "If the final digit when you attack is 4, the attack will deal 4x damage.";
		
			case CombatMagics.Defend: return "All damage is blocked until the next move.";
		}
		return "Unknown effects.";
	}
}

enum CombatMagics {
	AOE,
	Repeat2,
	RepeatN,
	
	TripleDamage,
	Combo,
	
	MoveTimeAdditional,
	//MoveTime,
	
	TimerDigitAdditional,
	TimerDigitIsFour,
	
	Defend,
	//ThornMoveTime,
	//ThornTimerDigit,
	
	Count,
};

function getCombatMagic(_enum) {
	var magic = new CombatMagic(_enum);
	
	switch (_enum) {
		case CombatMagics.AOE: { magic.cost = 4; } break;
		case CombatMagics.Repeat2: { magic.cost = 3; } break;
		case CombatMagics.RepeatN: { magic.cost = 5; } break;
	
		case CombatMagics.TripleDamage: { magic.cost = 6; } break;
		case CombatMagics.Combo: { magic.cost = 4; } break;
	
		case CombatMagics.MoveTimeAdditional: { magic.cost = 8; } break;
	
		case CombatMagics.TimerDigitAdditional: { magic.cost = 3; } break;
		case CombatMagics.TimerDigitIsFour: { magic.cost = 4; } break;
	
		case CombatMagics.Defend: { magic.cost = 3; } break;
	}
	
	return magic;
}