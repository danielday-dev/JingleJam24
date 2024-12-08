var w = 100, h = 50;
var right = camera_get_view_width(view_camera[0]);


var sklw = h, sklh = h
var sklx = right - w - (sklw / 2), skly = 0 + (sklh / 2);
var scl = sklw / sprite_get_width(spr_icons_gui);
draw_sprite_ext(spr_icons_gui, 0, sklx - (sklw / 2), skly - (sklh / 2), scl, scl, 0, c_white, 1.0);

draw_number(right - w, 0, w, h, max(0, displayTimer), tempDown > 0, 3, displayTimer <= 0.9);