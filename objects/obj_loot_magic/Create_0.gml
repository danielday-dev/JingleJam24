event_inherited();

offsetTarget = new Vector2(20, 0);
disabledTarget = new Vector2(-50, 0);
canInteractFunc = function() { 
	return 
		obj_gameStateManager.lootIsMagic &&
		array_length(obj_player.combatAvailableMagic) + 1 > magicIndex;
} 
