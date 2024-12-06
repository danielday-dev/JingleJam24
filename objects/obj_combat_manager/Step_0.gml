var distance = targetScale - variableScale;

if (distance == 0) return;

if (distance > 0) {
	variableScale += getDeltaTime();
	if (variableScale > targetScale)
		variableScale = targetScale;
} else {
	variableScale -= getDeltaTime();
	if (variableScale < targetScale)
		variableScale = targetScale;
}
