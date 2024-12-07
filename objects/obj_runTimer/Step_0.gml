var target = obj_gameStateManager.runTimer - tempDown;
var change = target - displayTimer;

if (change == 0) return;

var changeSpeed = abs(change);

if (change > 0) {
	displayTimer += displaySpeed * changeSpeed * getDeltaTime();
	if (displayTimer > target)
		displayTimer = target;
} else {
	displayTimer -= displaySpeed * changeSpeed * getDeltaTime();
	if (displayTimer < target)
		displayTimer = target;
}
