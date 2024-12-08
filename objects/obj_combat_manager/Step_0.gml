var distance = targetScale - variableScale;
if (distance != 0) {
	if (distance > 0) {
		variableScale += getDeltaTime();
		if (variableScale > targetScale)
			variableScale = targetScale;
	} else {
		variableScale -= getDeltaTime();
		if (variableScale < targetScale)
			variableScale = targetScale;
	}
}

if (!visible || Animator_isActive()) return;
if (cooldown > 0) cooldown -= getDeltaTime();
if (cooldown > 0) return;

var combatEntities = array_concat([ obj_player], obj_gameStateManager.combatEnemies);
var minTime = combatEntities[0].entityTurnTimer;
for (var i = 1; i < array_length(combatEntities); i++)
	minTime = min(minTime, combatEntities[i].entityTurnTimer);
	
if (minTime > 0) {
	obj_gameStateManager.runTimer--;
	for (var i = 0; i < array_length(combatEntities); i++)
		combatEntities[i].entityTurnTimer--;
	cooldown = 0.2;
	return;
}


turnOwner = noone;
for (var i = 0; i < array_length(combatEntities); i++) {
	if (combatEntities[i].entityTurnTimer <= 0) {
		turnOwner = combatEntities[i].id;
		break;
	}
}

if (turnOwner == obj_player.id) {
	return;
}
		
// Fuck about.
Combat_takeTurn(turnOwner);