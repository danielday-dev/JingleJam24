event_inherited();

offsetTarget = new Vector2(0, -20);
disabledTarget = new Vector2(0, 60);
canInteractFunc = function() { 
	return 
		!obj_gameStateManager.lootIsMagic &&
		array_length(obj_player.combatAvailableMoves) + 1 > moveIndex; 
} 
