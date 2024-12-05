

if (keyboard_check_released(vk_f1)) {
	originTarget = new Vector2(room_width / 2, room_height / 2);
	with (obj_star) {
		dist = random_range(10, 20);	
	}
}
if (originTarget.x < 0 || originTarget.y < 0) return;

with (obj_star) {
	var pos = new Vector2(x, y);
	var change = other.originTarget.subtract(pos);
	if (change.length() > 0) {
		direction = radtodeg(change.angle()) - dist;
	}
	speed = 2;
}

if (keyboard_check_released(vk_f2)) {
	with (obj_star) {
		dist = -random_range(70, 90);	
	}
}
if (keyboard_check_released(vk_f3)) {
	originTarget = new Vector2(room_width / 2, room_height - 50);
	with (obj_star) {
		dist = random_range(70, 90);	
	}
}
if (keyboard_check_released(vk_f4)) {
	originTarget.x = -1;
	with (obj_star) {
		x = sx;
		y = sy;
		speed = 0;
	}	
}