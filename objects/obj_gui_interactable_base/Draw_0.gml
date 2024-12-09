var imageIndex = GUI_isHovered() | (GUI_isActive() << 1);
if (disabled) imageIndex = 4;

draw_panel(x, y, sprite_width, sprite_height, imageIndex);

if (text != "") {
	var border = 5;
	draw_text_bound(x + border, y + border, sprite_width - (border * 2), sprite_height - (border * 2), text, textScale, disabled ? make_color_rgb(153, 117, 119) : make_color_rgb(246, 214, 189));
}