var target = GUI_isHovered() ? 1.0 : 0.0;

var change = target - offsetTransitionAmount;
if (change == 0) return;

if (change > 0) {
	offsetTransitionAmount += getDeltaTime() / offsetTransitionTime;
	if (offsetTransitionAmount > target)
		offsetTransitionAmount = target;
} else {
	offsetTransitionAmount -= getDeltaTime() / offsetTransitionTime;
	if (offsetTransitionAmount < target)
		offsetTransitionAmount = target;
}

var pos = originalPosition.interpolate(originalPosition.add(offsetTarget), ease(offsetTransitionAmount));
x = pos.x;
y = pos.y;