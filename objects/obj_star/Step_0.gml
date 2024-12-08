if (!returnHome) return;

if (distance_to_point(sx, sy) > 3) {
	move_towards_point(sx, sy, 3);
	return;
}

returnHome = false;
x = sx;
y = sy;
speed = 0;
visible = true;