var density = 0.01;
var starCount = density * room_width * room_height;
for (var i = 0; i < starCount; i++) {
	var sx = irandom(room_width - 1);	
	var sy = irandom(room_height - 1);	
	var star = instance_create_depth(sx, sy, depth, obj_star);
}
originTarget = new Vector2(-1, -1);