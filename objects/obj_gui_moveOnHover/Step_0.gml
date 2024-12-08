event_inherited();

var target = GUI_isHovered() ? 1.0 : (disabled ? -1.0 : 0.0);

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

var pos = offsetTransitionAmount >= 0 ? 
	originalPosition.interpolate(originalPosition.add(offsetTarget), ease(offsetTransitionAmount)) :
	originalPosition.interpolate(originalPosition.add(disabledTarget), ease(-offsetTransitionAmount));
x = pos.x;
y = pos.y;