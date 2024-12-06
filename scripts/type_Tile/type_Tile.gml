enum TileType {
	None,
	
	Empty,
	
	Enemy,
	Campfire,
	Event,
	
	Count
};

#macro TILESCALE 64

function Tile(_tileType, _args) constructor {
	tileType = _tileType;
	floorIndex = irandom(sprite_get_number(spr_floor_discovered));
	discovered = false;
	discoveredNeighbour = false;
	
	args = _args;
	
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
			if (discoveredNeighbour && tileType >= TileType.Enemy) {
				draw_sprite(spr_icons_tiles, tileType - TileType.Enemy, dx, dy);	
			}
		}
		
		switch (tileType) {
			case TileType.Enemy: {
				with (args.enemies[0]) {
					visible = other.discovered;
				}
				for (var i = 1; i < array_length(args.enemies); i++) {
					args.enemies[i].visible = false;	
				}
			} break;
			case TileType.Campfire: {
				if (discovered) draw_sprite(spr_tile_campfire, 0, hx, hy - 10);
			} break; 	
		}
	}	
}