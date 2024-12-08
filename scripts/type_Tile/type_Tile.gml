enum TileType {
	None,
	
	Empty,
	
	Entrance, Exit,
	
	Enemy,
	Campfire,
	Event,
	
	Count
};

#macro TILESCALE 64

function Tile(_tileType, _args = {}) constructor {
	tileType = _tileType;
	floorIndex = irandom(sprite_get_number(spr_floor_discovered));
	discovered = false;
	discoveredNeighbour = false;
	
	args = _args;
	
	switch (_tileType) {
		case TileType.Event:
		case TileType.Campfire: args.used = false; break;	
		case TileType.Exit:
		case TileType.Entrance: discoveredNeighbour = true; break;	
	}
	
	static draw = function(_x, _y) {
		if (tileType == TileType.None) return;
		
		var dx = _x * TILESCALE;
		var dy = _y * TILESCALE;
		var hx = dx + (0.5 * TILESCALE);
		var hy = dy + (0.5 * TILESCALE);
		
		if (discovered) {
			draw_sprite(spr_floor_discovered, floorIndex, dx, dy);
		} else {
			draw_sprite(spr_floor_undiscovered, floorIndex, dx, dy);
			if (discoveredNeighbour && tileType >= TileType.Entrance) {
				draw_sprite(spr_icons_tiles, tileType - TileType.Entrance, dx, dy);	
			}
		}
		
		switch (tileType) {
			case TileType.Enemy: {
				var len = array_length(args.enemies);
				if (len <= 0) break;
				
				with (args.enemies[0]) {
					visible = other.discovered;
				}
				for (var i = 1; i < len; i++) {
					args.enemies[i].visible = false;	
				}
			} break;
			case TileType.Campfire: {
				if (discovered) draw_sprite(spr_tile_campfire, args.used, hx, hy - 10);
			} break; 	
			case TileType.Event: {
				if (discovered) draw_sprite(spr_tile_chest, args.used, hx, hy - 10);
			} break; 	
			case TileType.Entrance: {
				if (discovered) draw_sprite(spr_tile_entrance_exit, 0, hx - 20, hy);
			} break; 	
			case TileType.Exit: {
				if (discovered) draw_sprite(spr_tile_entrance_exit, 1, hx, hy);
			} break; 	
		}
	}	
}