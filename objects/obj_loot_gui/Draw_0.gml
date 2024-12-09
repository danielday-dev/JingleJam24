event_inherited();

var statSize = 16;
var border = 8;
var dl = x + border, dt = y + border + statSize;
var scale = (sprite_width - (border * 2)) / sprite_get_width(obj_gameStateManager.lootIsMagic ? spr_icons_magic : spr_icons_weapons);

if (obj_gameStateManager.lootIsMagic) {
	var magic = obj_gameStateManager.loot;
	
	draw_sprite_ext(spr_icons_magic, magic.type, dl, dt, scale, scale, 0, c_white, 1.0);
	
	if (GUI_isHovered()) {
		var width = 400, height = 48;
		var left = x + (sprite_width / 2) - (width / 2), top = y + sprite_height;
		draw_panel(left, top, width, height, 4);
		draw_text_bound(left + border, top + border, width - (border * 2), height - (border * 2), magic.getDescription(), 0.5);
	}
} else {
	var move = obj_gameStateManager.loot;
	var weaponIndex = move.weaponIndex;
	var timeCost = move.timeCost;

	draw_number(
		x + (sprite_width / 2) + border, y + border,
		(sprite_width / 2) - (border * 2), statSize, 
		timeCost
	);
	draw_number(
		x + border, y + border,
		(sprite_width / 2) - (border * 2), statSize, 
		-move.damage
	);

	draw_sprite_ext(spr_icons_weapons, weaponIndex, dl, dt, scale, scale, 0, c_white, 1.0);
}
