var totalWidth = sprite_width, totalHeight = sprite_height;
var tw = sprite_width / (image_xscale * 3), th = sprite_height / (image_yscale * 3);

var right = x + totalWidth, bottom = y + totalHeight;

var imageIndex = GUI_isHovered() | (GUI_isActive() << 1);

draw_sprite_part(sprite_index, imageIndex, 0, 0, tw, th, x, y);
draw_sprite_part(sprite_index, imageIndex, tw * 2, th * 2, tw, th, right - tw, bottom - th);
draw_sprite_part(sprite_index, imageIndex, tw * 2, 0, tw, th, right - tw, y);
draw_sprite_part(sprite_index, imageIndex, 0, th * 2, tw, th, x, bottom - th);

var ow = totalWidth - (tw * 2), oh = totalHeight - (th * 2);
var ox = x + tw, oy = y + th;
var iw = ow / tw , ih = oh / th;

draw_sprite_part_ext(sprite_index, imageIndex, tw, th, tw, th, x + tw, y + th, iw, ih, c_white, 1.0);
for (var i = 0; i < iw; i++) {
	draw_sprite_part(sprite_index, imageIndex, tw, 0, min(tw, ow), th, ox, y);
	draw_sprite_part(sprite_index, imageIndex, tw, th * 2, min(tw, ow), th, ox, bottom - th);
	ox += tw;
	ow -= tw;
}
for (var i = 0; i < ih; i++) {
	draw_sprite_part(sprite_index, imageIndex, 0, th, tw, min(th, oh), x, oy);
	draw_sprite_part(sprite_index, imageIndex, tw * 2, th, tw, min(th, oh), right - tw, oy);
	oy += th;
	oh -= th;
}