switch (currentGameState) {
	case GameState.Campfire:
	case GameState.Combat:
	case GameState.Level: {
		var xLen = array_length(tiles);
		for (var ix = 0; ix < xLen; ix++) {
			var yLen = array_length(tiles[ix]);
			for (var iy = 0; iy < yLen; iy++) {
				tiles[ix][iy].draw(ix, iy);
			}
		}
	} break;
}

draw_rectangle(50, 50, 150, 150, true)
draw_number(50, 50, 100, 100, (get_timer() / 100000), true, 0);
draw_number(150, 50, 100, 100, -(get_timer() / 100000), true, 0);
