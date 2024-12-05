var inputActive = !Animator_isActive();

if (!inputActive) return;

if (currentGameState != targetGameState)
	currentGameState = targetGameState;

switch (currentGameState) {
	case GameState.Level: {
		if (mouse_check_button_pressed(mb_left)) {
			var mx = floor(mouse_x / TILESCALE);	
			var my = floor(mouse_y / TILESCALE);	
	
			if (GameState_discoverTile(mx, my)) {
				if (tiles[mx][my].tileType == TileType.Campfire) {
					targetGameState = GameState.Campfire;
				}
				
				//targetGameState = GameState.Combat;
				var animationInfo = {
					target: obj_player,
					startPos: new Vector2(obj_player.x, obj_player.y),
					endPos: new Vector2(mx, my)
				};
				Animator_dispatch(new AnimationInformation(
					0.5,
					AnimationType.Position, 
					AnimationInterpolation.EaseSine, 
					animationInfo
				));
			}
		}
	} break;
	case GameState.Campfire: {
		var animationInfo = {};
		if (campfireStart) {
			animationInfo = {
				target: obj_art_campfire,
				startPos: obj_art_campfire.offPos,
				endPos: obj_art_campfire.startPos
			};
			
			campfireStart = false;
		} else {
			animationInfo = {
				target: obj_art_campfire,
				startPos: obj_art_campfire.startPos,
				endPos: obj_art_campfire.offPos
			};
			
			campfireStart = true;
			targetGameState = GameState.Level;			
		}
		Animator_dispatch(new AnimationInformation(
			1.0,
			AnimationType.Position, 
			AnimationInterpolation.EaseSine, 
			animationInfo
		));
	} break;

}