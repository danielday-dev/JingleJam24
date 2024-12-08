event_inherited();


if (array_length(obj_player.combatAvailableMagic) <= magicIndex) return;

var border = 2;

var th = sprite_height - (border * 2), tw = th;
var left = x + (sprite_width - border) - tw, top = y + border;
var scale = tw / sprite_get_width(spr_icons_magic);

var active = obj_player.combatAvailableMagic[magicIndex].isActive();
var color = make_color_rgb(246, 205, 38);

if (active)
	draw_rectangle_color(x, top + (4 * scale), left + tw - (10 * scale), top + th - (6 * scale), color, color, color, color, false);
draw_sprite_ext(spr_icons_magic, obj_player.combatAvailableMagic[magicIndex].type, left, top, scale, scale, 0, c_white, 1.0);
if (!active)
	if (obj_player.combatAvailableMagic[magicIndex].used)
		draw_sprite_ext(spr_icons_magic, CombatMagics.Count + 1, left, top, scale, scale, 0, c_white, 1.0);
	else 
		draw_sprite_ext(spr_icons_magic, CombatMagics.Count, left, top, scale, scale, 0, c_white, 1.0);

if (GUI_isHovered()) {
	var left = x + sprite_width, top = y;
	var width = 400, height = sprite_height;
	draw_panel(left, top, width, height, 4);
	draw_text_bound(left + border, top + border, width - (border * 2), height - (border * 2), obj_player.combatAvailableMagic[magicIndex].getDescription(), 0.5);
}
