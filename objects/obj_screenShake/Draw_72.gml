// Handle shake.
if (shakeAmount > 0) {
	var a = random(360);
	var d = random_range(shakeAmount * 0.75, shakeAmount);
	x += sin(a) * d;
	y += cos(a) * d;

	shakeAmount *= shakeDampen;
}
x *= shakeDampen;
y *= shakeDampen;

// Camera shooken.
camera_set_view_pos(view_camera[0], x, y);