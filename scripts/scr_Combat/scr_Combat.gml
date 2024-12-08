function Combat_takeTurn(_entity) {
	var len = array_length(_entity.combatAvailableMoves);
	if (len == 0) {
		_entity.entityTurnTimer = 999;
		return;
	}
	
	Combat_performMove(_entity, _entity.plannedMove);
	_entity.plannedMove = irandom(array_length(_entity.combatAvailableMoves) - 1);
}

function Combat_canHitPlayer(_entity) {
	if (obj_player.plannedMove == -1) return false;
	var move = obj_player.combatAvailableMoves[obj_player.plannedMove];

	// TODO: Magic stuff.

	if (_entity.entityHealth <= move.damage) return false;
	if (_entity.entityTurnTimer >= move.timeCost) return false;
	
	return true;
}

function Combat_calculatePotentialPlayerDamage() { 
	 var totalDamage = 0;
	 var len = array_length(obj_gameStateManager.combatEnemies);
	 for (var i = 0; i < len; i++) {
		var enemy = obj_gameStateManager.combatEnemies[i];
		if (!Combat_canHitPlayer(enemy)) continue;
		
		totalDamage += enemy.combatAvailableMoves[enemy.plannedMove].damage;
	 }
	 
	return totalDamage;
}
function Combat_calculatePotentialDamage(_entity) {
	if (_entity == obj_player.id) return Combat_calculatePotentialPlayerDamage();
	if (array_length(obj_gameStateManager.combatEnemies) <= 0 || _entity != obj_gameStateManager.combatEnemies[0]) return 0;
	
	if (obj_player.plannedMove == -1) return 0;
	var move = obj_player.combatAvailableMoves[obj_player.plannedMove];
	 
	 // TODO: Magic stuff.
	 
	return move.damage;
}

function Combat_performMove(_entity, _moveIndex) {
	var move = _entity.combatAvailableMoves[_moveIndex];
	_entity.entityTurnTimer = move.timeCost;
	
	if (array_length(obj_gameStateManager.combatEnemies) <= 0) return;
	var _target = (_entity == obj_player.id) ? obj_gameStateManager.combatEnemies[0] : obj_player.id;
	var _damage = move.damage;
	
	Animator_dispatch(0.6, AnimationType.Custom, AnimationInterpolation.Linear, {
		entity: _entity,
		target: _target,
		damage: _damage,
		crossed: false,
		func: function(_t, _args) {
			var entity = _args.entity;
			var center = new Vector2(300, 200).subtract(entity.baseDrawPos);
			
			var t = 0, h = 0;
			
			if (_t < 0.5) {
				// Jump in.
				t = _t * 2;
				h = 40;
			} else {
				// Jump back.
				t = 1.0 - ((_t - 0.5) * 2);
				h = 10;
				
				if (!_args.crossed) {
					_args.crossed = true;
					_args.target.entityHealth -= _args.damage;
					
					with (obj_gameStateManager) {
						for (var i = 0; i < array_length(combatEnemies); i++) {
							if (combatEnemies[i].entityHealth > 0) continue;
							instance_destroy(combatEnemies[i]);
							array_delete(combatEnemies, i, 1);
							i--;
						}
					}
				}
			}
			
			entity.baseDrawOffset = center.multiply(new Vector2(t, t)).subtract(new Vector2(0, sin(pi * t) * h));
		}
	});
}