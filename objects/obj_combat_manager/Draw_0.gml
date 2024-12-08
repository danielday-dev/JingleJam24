
with (obj_gameStateManager) {
	var drawDebug = draw_debugEnabled();
	var len = array_length(combatEnemies);
	//len = 1;
	var drawScale = 3; // TODO: Dynamic based on enemy size.
	var spacing = 2; 
	
	var counterHeight = 20;
	var healthHeight = 16;
		
	var enemyCenter = new Vector2(350, 150);
	var playerCenter = new Vector2(250, 250);
	
	var playerMoveTime = 0;
	if (obj_player.plannedMove != -1) {
		playerMoveTime = obj_player.combatAvailableMoves[obj_player.plannedMove].timeCost;	
	}
	
	var totalEnemyWidth = 0;
	var maxScale = 1.0;
	var maxMultiplier = 1.0;
	for (var i = 0; i < len; i++) {
		totalEnemyWidth += sprite_get_width(combatEnemies[i].sprite_index) * combatEnemies[i].entityScale;
		maxScale = max(maxScale, combatEnemies[i].entityScale);
		maxMultiplier = max(maxMultiplier, combatEnemies[i].renderScale);
	}
	totalEnemyWidth += spacing * (len - 1);
	maxScale *= maxMultiplier;
	
	other.targetScale = maxScale;
	drawScale /= other.variableScale;

	totalEnemyWidth *= drawScale;

	var iPos = -totalEnemyWidth / 2;
	if (drawDebug)
		draw_rectangle(
			enemyCenter.x + iPos, 
			enemyCenter.y - 50, 
			enemyCenter.x + iPos + totalEnemyWidth, 
			enemyCenter.y + 50, 
			true
		);	
	
	for (var i = 0; i < len; i++) {
		var enemy = combatEnemies[i];
		var entityScale = drawScale * combatEnemies[i].entityScale;
		var sprite = enemy.sprite_index;
		
		var sox = sprite_get_xoffset(sprite) * entityScale, soy = sprite_get_yoffset(sprite) * entityScale;
		
		if (drawDebug)
			draw_rectangle(
				enemyCenter.x + iPos, 
				enemyCenter.y - soy ,
				enemyCenter.x + iPos + (sprite_get_width(sprite) * entityScale), 
				enemyCenter.y + (sprite_get_height(sprite) * entityScale) - soy,
				true
			);
		
		enemy.baseDrawPos.x = enemyCenter.x + iPos + sox;
		enemy.baseDrawPos.y = enemyCenter.y;
		draw_sprite_ext(
			sprite, enemy.image_index,
			enemy.baseDrawPos.x + enemy.baseDrawOffset.x, 
			enemy.baseDrawPos.y + enemy.baseDrawOffset.y, 
			entityScale, entityScale, 0, c_white, 1.0
		);	
		
		var canHitPlayer =  Combat_canHitPlayer(enemy);
		draw_number(enemyCenter.x + iPos, enemyCenter.y - (soy + counterHeight), (sprite_get_width(sprite) * entityScale), counterHeight, max(0, enemy.entityTurnTimer - playerMoveTime), canHitPlayer);
		draw_healthBar(enemyCenter.x + iPos, enemyCenter.y - (soy + counterHeight + healthHeight), (sprite_get_width(sprite) * entityScale), healthHeight, enemy.entityHealth, enemy.entityHealthMax, Combat_calculatePotentialDamage(enemy));
				
		iPos += (sprite_get_width(sprite) * entityScale) + (spacing * drawScale);
	}

	var playerSprite = obj_player.sprite_index;
	obj_player.baseDrawPos.x = playerCenter.x;
	obj_player.baseDrawPos.y = playerCenter.y;
	draw_sprite_ext(
		playerSprite, obj_player.image_index, 
		obj_player.baseDrawPos.x + obj_player.baseDrawOffset.x, 
		obj_player.baseDrawPos.y + obj_player.baseDrawOffset.y, 
		drawScale, drawScale, 0, c_white, 1.0
	);
	if (obj_player.entityTurnTimer > 0)
		draw_number(
			playerCenter.x - (sprite_get_xoffset(playerSprite) * drawScale),
			playerCenter.y - (sprite_get_yoffset(playerSprite) * drawScale) - counterHeight,
			sprite_get_width(playerSprite) * drawScale,
			counterHeight,
			obj_player.entityTurnTimer
		);	
		
	draw_healthBar(10, room_height - 50, 110, 20, obj_player.entityHealth, obj_player.entityHealthMax, Combat_calculatePotentialPlayerDamage());
	
	if (drawDebug) {
		draw_circle(playerCenter.x, playerCenter.y, 5, true);
		draw_circle(enemyCenter.x, enemyCenter.y, 5, true);
		draw_point(enemyCenter.x, enemyCenter.y);
	}
}

obj_runTimer.tempDown = 0;
if (obj_player.plannedMove != -1) {
	var move = obj_player.combatAvailableMoves[obj_player.plannedMove]
	obj_runTimer.tempDown = move.timeCost;
	obj_player.plannedMove = -1;
} 