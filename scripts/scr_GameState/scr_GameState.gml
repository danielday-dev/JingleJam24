function GameState_consumeTime(_time) {
	obj_gameStateManager.runTimer = max(0, obj_gameStateManager.runTimer - _time);
}


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
function GameState_finishTile(_x, _y){
	if (!GameState_tileExists(_x, _y)) return;
	
	switch (obj_gameStateManager.tiles[_x][_y].tileType) {
		case TileType.Entrance: break;
		case TileType.Exit: break;
		
		case TileType.Event:
		case TileType.Campfire: {
			obj_gameStateManager.tiles[_x][_y].args.used = true;
		} break;
		
		case TileType.Enemy: {
			var len = array_length(obj_gameStateManager.tiles[_x][_y].args.enemies);
			for (var i = 0; i < len; i++) {
				obj_gameStateManager.tiles[_x][_y].args.enemies[i].visible = false;
			}
		};
		default: obj_gameStateManager.tiles[_x][_y].tileType = TileType.Empty; break;
	}
}

function GameState_generateLevel(_width, _height) {
	with (obj_gameStateManager) {
		tiles = [];
		for (var ix = 0; ix < _width; ix++) {
			tiles[ix] = [];
			for (var iy = 0; iy < _height; iy++) {
				tiles[ix][iy] = new Tile(TileType.Empty);
				tiles[ix][iy].discovered = true;
			}
		}
		
		// Get start and end.
		var midPoint = _width / 2;
		var startPoint = new Vector2(irandom_range(0, midPoint - 1), irandom(_height - 1));
		var endPoint = new Vector2(irandom_range(midPoint, _width - 1), irandom_range(1, _height - 1));
		tiles[_width - 1][0].tileType = TileType.None;
		tiles[_width - 2][0].tileType = TileType.None;
		
		// Try to remove some tiles.
		var removeCount = 15;
		var removeTries = 20;
		while (removeCount > 0 && removeTries > 0) {
			var pos = new Vector2(random(_width - 1), irandom(_height - 1));
			if (pos.equal(startPoint) || pos.equal(endPoint)) continue;
		
			var oldTile = tiles[pos.x][pos.y];
			if (oldTile.tileType == TileType.None) continue;
			
			// Try to remove.
			removeTries--;
			tiles[pos.x][pos.y] = new Tile(TileType.None);
			var checkPoints = [ startPoint, new Vector2(1, 1), new Vector2(1, _height - 2), new Vector2(_width - 2, 1), new Vector2(_width - 2, _height - 2) ]; 
			var pathValid = true;
			for (var i = 0; i < array_length(checkPoints) && pathValid; i++)
				if (array_length(GameState_pathFind(checkPoints[i].x, checkPoints[i].y, endPoint.x, endPoint.y)) == 0)
					pathValid = false;	
			if (!pathValid) {
				// Remove failed.
				tiles[pos.x][pos.y] = oldTile;
			} else {
				// Remove success.
				removeCount--;
			}
		}
		
		// Forget tiles.
		for (var ix = 0; ix < _width; ix++)
			for (var iy = 0; iy < _height; iy++)
				tiles[ix][iy].discovered = false;
		
		// Fill tiles.
		function placeRandom(_minCount, _maxCount, _tileType, _width, _height) {
			var count = irandom_range(_minCount, _maxCount);
			// Get empty tiles.
			var emptyTiles = [];
			for (var ix = 0; ix < _width; ix++)
				for (var iy = 0; iy < _height; iy++)
					if (tiles[ix][iy].tileType == TileType.Empty)
						emptyTiles[array_length(emptyTiles)] = new Vector2(ix, iy);
			// Place.
			var len = array_length(emptyTiles);
			emptyTiles = array_shuffle(emptyTiles, 0, len);
			for (var i = 0; i < len && i < count; i++) {
				var pos = emptyTiles[i];
				args = {};
				switch (_tileType) {
					case TileType.Enemy: {
						var enemy = instance_create_depth(pos.x, pos.y, depth, obj_enemy_test);
						var enemy2 = instance_create_depth(pos.x, pos.y, depth, obj_enemy_test);
						args.enemies = [ enemy, enemy2 ]; 
					} break;
				}
				tiles[pos.x][pos.y] = new Tile(_tileType, args);
			}
		}
		
		
		// Set tiles.
		tiles[startPoint.x][startPoint.y] = new Tile(TileType.Entrance);
		tiles[endPoint.x][endPoint.y] = new Tile(TileType.Exit);
		
		// Set activities.
		placeRandom(5, 8, TileType.Campfire, _width, _height);
		placeRandom(2, 5, TileType.Event, _width, _height);
		placeRandom(8, 16, TileType.Enemy, _width, _height);
		
		// Setup player.
		with (obj_player) {
			x = startPoint.x;
			y = startPoint.y;
			GameState_discoverTile(x, y);
		}
	}
}

function GameState_isTraversable(_tx, _ty) {
	if (!GameState_tileExists(_tx, _ty)) return false;
	
	var tile = obj_gameStateManager.tiles[_tx][_ty];
	if (tile.tileType == TileType.None) return false;
	return tile.discoveredNeighbour || tile.discovered;
}

function GameState_pathFind(_fx, _fy, _tx, _ty) {
	function Node(_pos, _moveCost, _heuristic, _path) constructor {
		pos = _pos;
		moveCost = _moveCost;
		heuristic = _heuristic;
		path = _path;
	}
	
	var start = new Vector2(_fx, _fy);
	var target = new Vector2(_tx, _ty);
	var nodes = [
		new Node(start, 0, target.subtract(start).manhattan(), [ start ])
	];
	var visitedNodes = [];
	
	var checks = [
		new Vector2(1, 0),
		new Vector2(-1, 0),
		new Vector2(0, 1),
		new Vector2(0, -1),
	];
	var checkCount = array_length(checks);
	
	while (array_length(nodes) > 0) {
		var bestI = 0;
		var len = array_length(nodes);
		for (var i = 1; i < len; i++)
			if (nodes[bestI].heuristic > nodes[i].heuristic)
				bestI = i;
				
		var node = nodes[bestI];
		array_delete(nodes, bestI, 1);
		if (node.pos.equal(target)) return node.path;

		var alreadyVisited = false; 
		for (var j = 0; j < array_length(visitedNodes) && !alreadyVisited; j++) {
			if (!visitedNodes[j].pos.equal(node.pos)) continue;
			alreadyVisited = true;
			
			if (visitedNodes[j].heuristic > checkHeuristic)
				visitedNodes[j].heuristic = checkHeuristic;
		}
		if (!alreadyVisited) {
			visitedNodes[array_length(visitedNodes)] = {
				pos: node.pos, 
				heuristic: node.heuristic,
			};
		}
		
		if (!obj_gameStateManager.tiles[node.pos.x][node.pos.y].discovered) continue;
		
		var checkCost = node.moveCost + 1;
		for (var i = 0; i < checkCount; i++) {
			var checkPos = node.pos.add(checks[i]);
			if (!GameState_isTraversable(checkPos.x, checkPos.y)) continue;
			
			var checkHeuristic = checkCost + target.subtract(checkPos).manhattan();
			alreadyVisited = false;
			for (var j = 0; j < array_length(visitedNodes) && !alreadyVisited; j++)
				if (visitedNodes[j].pos.equal(checkPos) && visitedNodes[j].heuristic <= checkHeuristic)	
					alreadyVisited = true;
			if (alreadyVisited) continue;
			
			nodes[array_length(nodes)] = new Node(
				checkPos , 
				checkCost, 
				checkHeuristic ,
				array_concat(node.path, [ checkPos ])
			);
		}
	}
	
	return [];
}