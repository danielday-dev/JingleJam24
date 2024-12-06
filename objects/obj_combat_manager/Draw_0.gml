with (obj_gameStateManager) {
	var len = array_length(combatEnemies);
	//len = 1;
	
	var drawScale = 3; // TODO: Dynamic based on enemy size.
	var spacing = 2; 
		
	var enemyCenter = new Vector2(350, 150);
	var playerCenter = new Vector2(250, 250);
	
	var totalEnemyWidth = 0;
	var maxScale = 1.0;
	for (var i = 0; i < len; i++) {
		totalEnemyWidth += sprite_get_width(combatEnemies[i].sprite_index) * combatEnemies[i].entityScale;
		maxScale = max(maxScale, combatEnemies[i].entityScale);
	}
	totalEnemyWidth += spacing * (len - 1);
	
	other.targetScale = maxScale;
	drawScale /= other.variableScale;

	totalEnemyWidth *= drawScale;

	var iPos = -totalEnemyWidth / 2;
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
		
		draw_rectangle(
			enemyCenter.x + iPos, 
			enemyCenter.y - soy ,
			enemyCenter.x + iPos + (sprite_get_width(sprite) * entityScale), 
			enemyCenter.y + (sprite_get_height(sprite) * entityScale) - soy,
			true
		);
		
		draw_sprite_ext(
			sprite, enemy.image_index, 
			enemyCenter.x + iPos + sox, 
			enemyCenter.y, 
			entityScale, entityScale, 0, c_white, 1.0
		);	
		iPos += (sprite_get_width(sprite) * entityScale) + (spacing * drawScale);
	}

	var playerSprite = obj_player.sprite_index;
	draw_sprite_ext(
		playerSprite, obj_player.image_index, 
		playerCenter.x, 
		playerCenter.y, 
		drawScale, drawScale, 0, c_white, 1.0
	);
	draw_circle(playerCenter.x, playerCenter.y, 5, true);
	draw_circle(enemyCenter.x, enemyCenter.y, 5, true);
	draw_point(enemyCenter.x, enemyCenter.y);

}