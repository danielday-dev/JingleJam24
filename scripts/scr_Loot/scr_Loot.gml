 function LootTable(_level, _commonChance, _uncommonChance, _rareChance, _temporalChance) constructor {
	level = _level;
	commonChance = _commonChance;
	uncommonChance = _uncommonChance;
	rareChance = _rareChance;
	temporalChance = _temporalChance;	 
	
	static rollChance = function() {
		var chances = [ commonChance, uncommonChance, rareChance, temporalChance ];
		var len = array_length(chances);
		
		var totalChance = 0;
		for (var i = 0; i < len; i++) totalChance += chances[i];
		
		var roll = random(totalChance);
		var index = 0;
		while ((index + 1) < len && roll > chances[index]) {
			roll -= chances[index];
			index++;
		}
		
		return index;		
	}
 }
 
 function Loot_getTableChances(_level, _tables) {
	var len = array_length(_tables);
	if (len == 0) return 0;
	if (len == 1) return _tables[0];
	
	if (_tables[0].level >= _level) return _tables[0];
	if (_tables[len - 1].level <= _level) return _tables[len - 1];
	
	var index = 0;
	while ((index + 2) < len && level < _tables[index + 1]) index++;
	
	var a = _tables[index], b = _tables[index + 1];
	var t = (_level - a.level) / (b.level - a.level)
	return new LootTable(
		_level, 
		lerp(a.commonChance, b.commonChance, t),	
		lerp(a.uncommonChance, b.uncommonChance, t),	
		lerp(a.rareChance, b.rareChance, t),	
		lerp(a.temporalChance, b.temporalChance, t)
	);
 }
 
/*
			[1]     [5]		[10]
common		0.6		0.2		0.05	
uncommon	0.2		0.45	0.4
rare		0.1		0.3		0.35
impossible	0.0		0.05	0.2

[2] = [1] -> 20% -> [5]

*/

 function Loot_getMagicDrop() {
	 static lootTables = [
		new LootTable(0, 0.8, 0.15, 0.05, 0),
		new LootTable(10, 0.05, 0.25, 0.45, 0.3),
	 ];
	 	
	 static loot = [
		[ CombatMagics.Repeat2, CombatMagics.AOE ], // Common
		[ CombatMagics.TimerDigitAdditional, CombatMagics.MoveTimeAdditional ], // Uncommon
		[ CombatMagics.RepeatN, CombatMagics.Combo, CombatMagics.TripleDamage ], // Rare
		[ CombatMagics.TimerDigitIsFour ], // Temporal
	 ];
	 
	 var tableIndex = Loot_getTableChances(obj_gameStateManager.level, lootTables).rollChance();
	 if (tableIndex < 0) tableIndex = 0;
	 if (tableIndex >= array_length(loot)) tableIndex = array_length(loot) - 1;
	 var table = loot[tableIndex];
	 var choice = irandom(array_length(table) - 1)
	 return getCombatMagic(loot[tableIndex][choice]);
 }
 
 function Loot_getMoveDrop() {
	 static lootTables = [
		new LootTable(0, 0.8, 0.15, 0.05, 0),
		new LootTable(10, 0.05, 0.25, 0.45, 0.3),
	 ];
	
	 static loot = [
		[ CombatMoves.Sword_Wood, CombatMoves.Axe_Wood, CombatMoves.Dagger_Wood, CombatMoves.Staff_Wood ], // Common
		[ CombatMoves.Sword_Iron, CombatMoves.Axe_Iron, CombatMoves.Dagger_Iron, CombatMoves.Staff_Iron ], // Uncommon
		[ CombatMoves.Sword_Gold, CombatMoves.Axe_Gold, CombatMoves.Dagger_Gold, CombatMoves.Staff_Gold ], // Rare
		[ CombatMoves.Sword_Temporal, CombatMoves.Axe_Temporal, CombatMoves.Dagger_Temporal,  CombatMoves.Staff_Temporal ], // Temporal
	 ];
	 
	 var tableIndex = Loot_getTableChances(obj_gameStateManager.level, lootTables).rollChance();
	 if (tableIndex < 0) tableIndex = 0;
	 if (tableIndex >= array_length(loot)) tableIndex = array_length(loot) - 1;
	 var table = loot[tableIndex];
	 var choice = irandom(array_length(table) - 1)
	 return getCombatMove(loot[tableIndex][choice]);
 }