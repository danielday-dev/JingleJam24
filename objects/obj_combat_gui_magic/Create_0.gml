event_inherited();

offsetTarget = new Vector2(20, 0);
disabledTarget = new Vector2(-50, 0);
canInteractFunc = function() { 
	return 
		obj_player.entityTurnTimer <= 0 && 
		array_length(obj_player.combatAvailableMagic) > magicIndex &&
		!obj_player.combatAvailableMagic[magicIndex].used; 
} 
