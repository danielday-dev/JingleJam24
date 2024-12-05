var deltaTime = getDeltaTime();

for (var i = 0; i < array_length(animationList); i++) {
	animationList[i].tick(deltaTime);
	
	if (animationList[i].hasCompleted()) {
		array_delete(animationList, i, 1);
		i--;
	}
}