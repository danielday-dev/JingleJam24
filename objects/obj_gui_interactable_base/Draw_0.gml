var totalWidth = sprite_width, totalHeight = sprite_height;
var tw = sprite_width / (image_xscale * 3), th = sprite_height / (image_yscale * 3);

var right = x + totalWidth, bottom = y + totalHeight;

draw_sprite_part(sprite_index, image_index, 0, 0, tw, th, x, y);
draw_sprite_part(sprite_index, image_index, tw * 2, th * 2, tw, th, right - tw, bottom - th);
draw_sprite_part(sprite_index, image_index, tw * 2, 0, tw, th, right - tw, y);
draw_sprite_part(sprite_index, image_index, 0, th * 2, tw, th, x, bottom - th);

//draw_sprite_part(sprite_index, image_index);
var ow = totalWidth - (tw * 2), oh = totalHeight - (th * 2);
var ox = x + tw, oy = y + th;
var iw = ow / tw , ih = ow / th;

draw_sprite_part_ext(sprite_index, image_index, tw, th, tw, th, x + tw, y + tw, ow / tw, oh / th, c_white, 1.0);
for (var i = 0; i < iw; i++) {
	draw_sprite_part(sprite_index, image_index, tw, 0, min(tw, ow), th, ox, y);
	draw_sprite_part(sprite_index, image_index, tw, th * 2, min(tw, ow), th, ox, bottom - th);
	ox += tw;
	ow -= tw;
}
for (var i = 0; i < ih; i++) {
	draw_sprite_part(sprite_index, image_index, 0, th, tw, min(th, oh), x, oy);
	draw_sprite_part(sprite_index, image_index, tw * 2, th, tw, min(th, oh), right - tw, oy);
	oy += th;
	oh -= th;
}