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


