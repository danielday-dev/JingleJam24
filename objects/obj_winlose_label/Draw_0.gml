if (text != "") {
	var border = 5;
	draw_text_bound(x + border, y + border, sprite_width - (border * 2), sprite_height - (border * 2), text, 1.0, disabled ? make_color_rgb(153, 117, 119) : make_color_rgb(246, 214, 189));
}