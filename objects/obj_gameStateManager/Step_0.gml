var inputActive = !Animator_isActive();
if (!inputActive) return;

if (array_length(playerPath) > 0) {
	var pos = playerPath[0];
	array_delete(playerPath, 0, 1);
	
	GameState_consumeTime(1);
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
		
		if (enterGameStates[stateIndex] != GameState.Level) {
			Stars_bringToDepth(enteringState ? -9500 : obj_starManager.depth);
		}
		
		///////////////////////////////////////////////////////
		//		Handle on state change.
		///////////////////////////////////////////////////////
		switch (enterGameStates[stateIndex]) {
			case GameState.Level: {
				if (enteringState) GameState_finishTile(obj_player.x, obj_player.y);
			} break;
			case GameState.Campfire: {
				if (enteringState) 
					obj_campfire_manager.healed = false;
				setGUIVisibility("Campfire", enteringState); 
				Animator_dispatch(0.2, AnimationType.BackgroundFade, AnimationInterpolation.Ease, { fade: enteringState ? 0.4 : 0.0 });
			} break;
			case GameState.Loot: {
				setGUIVisibility("Loot", enteringState); 
				Animator_dispatch(0.2, AnimationType.BackgroundFade, AnimationInterpolation.Ease, { fade: enteringState ? 0.8 : 0.0 });
			} break;
			case GameState.Exit: {
				setGUIVisibility("Exit", enteringState); 
				if (!enteringState) level++;
				Animator_dispatch(0.2, AnimationType.BackgroundFade, AnimationInterpolation.Ease, { fade: enteringState ? 0.4 : 0.0 });
			} break;
			case GameState.Combat: {
				if (enteringState) {
					with (obj_combat_manager) {
						variableScale = 0.5;
					}
					obj_player.entityTurnTimer = 0;
				} else {
					with (obj_player) {
						for (var i = 0; i < array_length(combatAvailableMagic); i++) {
							if (combatAvailableMagic[i].isActive()) {
								combatAvailableMagic[i].used = true;
								combatAvailableMagic[i].active = false;
							}
						}
						lastMove = -1;
					}
				}
				setGUIVisibility("Combat", enteringState); 
				if (enteringState || targetGameState == GameState.Level)
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
		if (runTimer <= 0) {
			targetGameState = GameState.Combat;
			combatEnemies = [ instance_create_depth(x, y, depth, obj_enemy_chronos) ];
			runTimer = bossAttackTime;			
			break;
		}
		
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
				if (tiles[mx][my].tileType == TileType.Exit) {
					targetGameState = GameState.Exit;
				}
			}
		}
	} break;
	
	case GameState.Combat:  {		
		if (array_length(combatEnemies) <= 0) {
			if (random(1.0) < 0.65) {
				lootIsMagic = random(1.0) < 0.35;
				loot = lootIsMagic ? Loot_getMagicDrop() : Loot_getMoveDrop();
				targetGameState = GameState.Loot;
			} else {
				targetGameState = GameState.Level;
			}
			
			tiles[obj_player.x][obj_player.y] = new Tile(TileType.Empty);
			GameState_discoverTile(obj_player.x, obj_player.y);
		}
	} break;
}