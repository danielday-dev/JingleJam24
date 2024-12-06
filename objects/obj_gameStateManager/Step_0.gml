var inputActive = !Animator_isActive();
if (!inputActive) return;

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
			case GameState.Campfire: {
				setGUIVisibility("Campfire", enteringState); 
				Animator_dispatch(0.2, AnimationType.BackgroundFade, AnimationInterpolation.Ease, { fade: enteringState ? 0.4 : 0.0 });
			} break;
			case GameState.Combat: {
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
	
			if (GameState_discoverTile(mx, my)) {
				if (tiles[mx][my].tileType == TileType.Campfire) {
					targetGameState = GameState.Campfire;
				}
				if (tiles[mx][my].tileType == TileType.Enemy) {
					targetGameState = GameState.Combat;
					combatEnemies = tiles[mx][my].args.enemies;
				}
				
				//targetGameState = GameState.Combat;
				Animator_dispatch(0.5, AnimationType.Position, AnimationInterpolation.EaseSine,  {
					target: obj_player,
					startPos: new Vector2(obj_player.x, obj_player.y),
					endPos: new Vector2(mx, my)
				});
			}
		}
	} break;
	
	case GameState.Combat: 
	case GameState.Campfire: {
		if (mouse_check_button_pressed(mb_left)) targetGameState = GameState.Level;
	} break;
}