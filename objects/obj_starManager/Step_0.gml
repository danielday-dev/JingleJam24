if (originTarget.x < 0 || originTarget.y < 0) return;

with (obj_star) {
	var pos = new Vector2(x, y);
	var change = other.originTarget.subtract(pos);
	if (change.length() > 0) {
		direction = radtodeg(change.angle()) - dist;
	}
	speed = 2;
}