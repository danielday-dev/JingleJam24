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
function GameState_finishTile(_x, _y){
	if (!GameState_tileExists(_x, _y)) return;
	
	switch (obj_gameStateManager.tiles[_x][_y].tileType) {
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
				var tileType = irandom(TileType.Count - 1);
				
				tiles[ix][iy] = new Tile(tileType, {});
				switch (tileType) {
					case TileType.Enemy: {
						var enemy = instance_create_depth(ix, iy, depth, obj_enemy_test);
						var enemy2 = instance_create_depth(ix, iy, depth, obj_enemy_test);
						tiles[ix][iy] = new Tile(tileType, { enemies: [ enemy, enemy2 ], } ); 
					} break;
				}
			}
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
	nodes = [
		new Node(start, 0, target.subtract(start).manhattan(), [ start ])
	];
	visitedNodes = [];
	
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