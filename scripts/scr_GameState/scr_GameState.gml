// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GameState_tileExists(_x, _y){
	var xLen = array_length(obj_gameStateManager.tiles);
	if (_x < 0 || xLen <= _x) return false;
	
	var yLen = array_length(obj_gameStateManager.tiles[_x]);
	if (_y < 0 || yLen <= _y) return false;
	
	return true;
}
function GameState_discoverTile(_x, _y){
	if (!GameState_tileExists(_x, _y)) return false;
	
	// Discover tile.
	if (obj_gameStateManager.tiles[_x][_y].discovered) return true;
	obj_gameStateManager.tiles[_x][_y].discovered = true;
		
	// Recurse.
	GameState_neighbourTile(_x - 1, _y);
	GameState_neighbourTile(_x + 1, _y);
	GameState_neighbourTile(_x, _y - 1);
	GameState_neighbourTile(_x, _y + 1);
	
	return true;
}
function GameState_neighbourTile(_x, _y){
	if (!GameState_tileExists(_x, _y)) return;
	
	// Discover tile.
	if (obj_gameStateManager.tiles[_x][_y].discoveredNeighbour) return;
	obj_gameStateManager.tiles[_x][_y].discoveredNeighbour = true;
	
	if (obj_gameStateManager.tiles[_x][_y].tileType == TileType.Empty) 
		GameState_discoverTile(_x, _y);
}

function GameState_generateLevel(_width, _height) {
	with (obj_gameStateManager) {
		tiles = [];
		for (var ix = 0; ix < _width; ix++) {
			tiles[ix] = [];
			for (var iy = 0; iy < _height; iy++) {
				var tileType = irandom(TileType.Count - 1);
				
				tiles[ix][iy] = new Tile(tileType, {});
				switch (tileType) {
					case TileType.Enemy: {
						var enemy = instance_create_depth(ix, iy, depth - 100, obj_enemy_test);
						tiles[ix][iy] = new Tile(tileType, { enemy: enemy, } ); 
					} break;
				}
			}
		}
	}
}