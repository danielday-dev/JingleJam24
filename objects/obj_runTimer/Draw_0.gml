with (obj_gameStateManager) {
	var w = 100, h = 60;
	var right = camera_get_view_width(view_camera[0]);
	draw_number(right - w, 0, w, h, runTimer, false, 3);
}