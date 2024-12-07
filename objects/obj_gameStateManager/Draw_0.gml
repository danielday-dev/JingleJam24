var xLen = array_length(tiles);
for (var ix = 0; ix < xLen; ix++) {
	var yLen = array_length(tiles[ix]);
	for (var iy = 0; iy < yLen; iy++) {
		tiles[ix][iy].draw(ix, iy);
	}
}

obj_runTimer.tempDown = 0;
var inputActive = !Animator_isActive();
if (!inputActive || currentGameState != GameState.Level) { 
	return;
}

var mx = floor(mouse_x / TILESCALE);	
var my = floor(mouse_y / TILESCALE);
if (GameState_isTraversable(mx, my)) {
	draw_rectangle(mx * TILESCALE, my * TILESCALE, (mx + 1) * TILESCALE, (my + 1) * TILESCALE, true);
	obj_runTimer.tempDown = max(0, array_length(GameState_pathFind(obj_player.x, obj_player.y, mx, my)) - 1);
}