event_inherited();

if (array_length(obj_player.combatAvailableMoves) <= moveIndex) return;

var move =  obj_player.combatAvailableMoves[moveIndex];
var weaponIndex = move.weaponIndex;
var timeCost = move.timeCost;

var border = 8;
var timeSize = new Vector2(16, 16);


draw_number(
	x + (sprite_width / 2) + border, y + border,
	(sprite_width / 2) - (border * 2), timeSize.y, 
	timeCost
);
draw_number(
	x + border, y + border,
	(sprite_width / 2) - (border * 2), timeSize.y, 
	-move.damage
);

var dl = x + border;
var dr = (x + sprite_width) - border;
var dt = y + border + timeSize.y;
var ds = (dr - dl) / sprite_get_width(spr_icons_weapons);

draw_sprite_ext(spr_icons_weapons, weaponIndex, dl, dt, ds, ds, 0, c_white, 1.0);