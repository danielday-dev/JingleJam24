var inputActive = !Animator_isActive();
if (!inputActive) return;

if (array_length(playerPath) > 0) {
	var pos = playerPath[0];
	array_delete(playerPath, 0, 1);
	
	obj_runTimer.tempDown = 0;
	
	runTimer--;
	GameState_discoverTile(pos.x, pos.y);
	Animator_dispatch(0.5, AnimationType.Position, AnimationInterpolation.EaseSine,  {
		target: obj_player,
		startPos: new Vector2(obj_player.x, obj_player.y),
		endPos: new Vector2(pos.x, pos.y)
	});

	return;
}


///////////////////////////////////////////////////////
if (currentGameState != targetGameState) {
	var enterState = [ false, true ];
	var enterGameStates = [ currentGameState, targetGameState ];
	var stateLen = min(array_length(enterState), array_length(enterGameStates));
	for (var stateIndex = 0; stateIndex < stateLen; stateIndex++) {
		var enteringState = enterState[stateIndex];
		
		///////////////////////////////////////////////////////
		//		Handle on state change.
		///////////////////////////////////////////////////////
		switch (enterGameStates[stateIndex]) {
			case GameState.Level: {
				if (enteringState) {
					GameState_finishTile(obj_player.x, obj_player.y);
				} else {
					obj_runTimer.tempDown = 0;
				}
			} break;
			case GameState.Campfire: {
				setGUIVisibility("Campfire", enteringState); 
				Animator_dispatch(0.2, AnimationType.BackgroundFade, AnimationInterpolation.Ease, { fade: enteringState ? 0.4 : 0.0 });
			} break;
			case GameState.Combat: {
				if (enteringState) {
					with (obj_combat_manager) {
						variableScale = 0.5;
					}
					obj_player.entityTurnTimer = 0;
				}
				setGUIVisibility("Combat", enteringState); 
				Animator_dispatch(0.3, AnimationType.BackgroundFade, AnimationInterpolation.Ease, { fade: enteringState ? 0.9 : 0.0 });
			} break;
		}
	}
	currentGameState = targetGameState;
}
	
///////////////////////////////////////////////////////
//		Handle live actions / inputs.
///////////////////////////////////////////////////////
switch (currentGameState) {
	case GameState.Level: {
		if (mouse_check_button_pressed(mb_left)) {
			var mx = floor(mouse_x / TILESCALE);	
			var my = floor(mouse_y / TILESCALE);	
	
			var path = GameState_pathFind(obj_player.x, obj_player.y, mx, my);
			var len = array_length(path);
	
			if (len != 0) {
				array_delete(path, 0, 1);
				playerPath = path;
				
				if (tiles[mx][my].tileType == TileType.Campfire && !tiles[mx][my].args.used) {
					targetGameState = GameState.Campfire;
				}
				if (tiles[mx][my].tileType == TileType.Enemy) {
					targetGameState = GameState.Combat;
					combatEnemies = tiles[mx][my].args.enemies;
				}
			}
		}
	} break;
	
	case GameState.Combat:  {		
		if (array_length(combatEnemies) <= 0) {
			tiles[obj_player.x][obj_player.y] = new Tile(TileType.Empty);
			targetGameState = GameState.Level;
			GameState_discoverTile(obj_player.x, obj_player.y);
		}
		
		if (mouse_check_button_pressed(mb_left) && GUIElement_hovered == noone) targetGameState = GameState.Level;
	} break;
	case GameState.Campfire: {
		if (mouse_check_button_pressed(mb_left) && GUIElement_hovered == noone) targetGameState = GameState.Level;
	} break;
}