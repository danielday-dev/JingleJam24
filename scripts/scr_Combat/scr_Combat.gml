function Combat_takeTurn(_entity) {
	var len = array_length(_entity.combatAvailableMoves);
	if (len == 0) {
		_entity.entityTurnTimer = 999;
		return;
	}
		
	Combat_performMove(_entity, _entity.plannedMove);
	_entity.plannedMove = irandom(len - 1);
}

function Combat_damageEntity(_entity, _damage) {
	_entity.entityHealth -= _damage;
	shakeScreen(_damage);

	if (_entity == obj_player.id) {
		if (obj_player.entityHealth <= 0) room_goto(rm_lose);		
		return;
	} 
					
	with (obj_gameStateManager) {
		for (var i = 0; i < array_length(combatEnemies); i++) {
			if (combatEnemies[i].entityHealth > 0) continue;
			instance_destroy(combatEnemies[i]);
			array_delete(combatEnemies, i, 1);
			i--;
		}
	}
}


function Combat_getEntityDamage(_entity) {
	if (_entity.plannedMove == -1) return 0;
	var move = _entity.combatAvailableMoves[_entity.plannedMove];
	var len = array_length(_entity.combatAvailableMagic);
	
	var damage = move.damage;
	
	// Addition.
	for (var i = 0; i < len; i++) {
		var magic = _entity.combatAvailableMagic[i];
		if (!magic.isActive()) continue;
		
		switch (magic.type) {
			case CombatMagics.Combo: if (_entity.lastMove == _entity.plannedMove) damage += move.damage * min(5, (magic.duration - 1)); break;
			case CombatMagics.MoveTimeAdditional: damage += move.timeCost; break;
			case CombatMagics.TimerDigitAdditional: damage += obj_gameStateManager.runTimer mod 10; break;
		}
	}
	
	// Multiplicative.
	for (var i = 0; i < len; i++) {
		var magic = _entity.combatAvailableMagic[i];
		if (!magic.isActive()) continue;
		
		switch (magic.type) {
			case CombatMagics.Repeat2: damage *= 2; break;
			case CombatMagics.RepeatN: damage *= array_length(obj_gameStateManager.combatEnemies); break;
			case CombatMagics.TripleDamage: damage *= 3; break;
			case CombatMagics.TimerDigitIsFour: if (obj_gameStateManager.runTimer mod 10 == 4) damage *= 4; break;
		}
	}
	
	return damage;
}

function Combat_canHitPlayer(_entity) {
	if (obj_player.plannedMove == -1) return false;
	var move = obj_player.combatAvailableMoves[obj_player.plannedMove];
	var playerDamage = Combat_getEntityDamage(obj_player.id)
	
	// TODO: Magic stuff?

	if (_entity.entityHealth <= playerDamage) return false;
	if (_entity.entityTurnTimer >= move.timeCost) return false;
	
	return true;
}

function Combat_calculatePotentialPlayerDamage() { 
	var totalDamage = 0;
	var len = array_length(obj_gameStateManager.combatEnemies);
	for (var i = 0; i < len; i++) {
		var enemy = obj_gameStateManager.combatEnemies[i];
		if (!Combat_canHitPlayer(enemy)) continue;
		
		totalDamage += Combat_getEntityDamage(enemy);
	}
	return totalDamage;
}
function Combat_calculatePotentialDamage(_entity) {
	if (_entity == obj_player.id) return Combat_calculatePotentialPlayerDamage();
	
	// Check for AOE.
	var hasAOE = false;
	for (var i = 0; i < array_length(obj_player.combatAvailableMagic) && !hasAOE; i++) {
		var magic = obj_player.combatAvailableMagic[i];
		if (!magic.isActive()) continue;
		switch (magic.type) {
			case CombatMagics.AOE: hasAOE = true; break;
		}
	}
	
	if (array_length(obj_gameStateManager.combatEnemies) <= 0 || 
		(!hasAOE && _entity != obj_gameStateManager.combatEnemies[0])) return 0;
	return Combat_getEntityDamage(obj_player.id);
}

function Combat_performMove(_entity, _moveIndex) {
	if (obj_gameStateManager.runTimer <= 0 && 
		instance_exists(obj_enemy_chronos) && _entity.id == obj_enemy_chronos.id) {
		with (obj_enemy_chronos) {
			event_user(1);
		}
		return;
	}
	
	_entity.plannedMove = _moveIndex;
	var move = _entity.combatAvailableMoves[_entity.plannedMove];
	_entity.entityTurnTimer = move.timeCost;
	
	var hasAOE = false;
	for (var i = 0; i < array_length(_entity.combatAvailableMagic) && !hasAOE; i++) {
		var magic = _entity.combatAvailableMagic[i];
		if (!magic.isActive()) continue;
		switch (magic.type) {
			case CombatMagics.AOE: hasAOE = true; break;
		}
	}
	
	if (array_length(obj_gameStateManager.combatEnemies) <= 0) return;
	var _targets = 
		(_entity == obj_player.id) ? 
		(hasAOE ? 
			obj_gameStateManager.combatEnemies : 
			[ obj_gameStateManager.combatEnemies[0] ]) : 
		[ obj_player.id ];
	var _damage = Combat_getEntityDamage(_entity);
	
	for (var i = 0; i < array_length(_entity.combatAvailableMagic); i++)
		if (_entity.combatAvailableMagic[i].isActive())
			_entity.combatAvailableMagic[i].use(_entity);
	_entity.lastMove = _entity.plannedMove;
	
	Animator_dispatch(0.6, AnimationType.Custom, AnimationInterpolation.Linear, {
		entity: _entity,
		targets: _targets,
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
					for (var i = array_length(_args.targets) - 1; i >= 0; i--)
						Combat_damageEntity(_args.targets[i], _args.damage);
				}
			}
			
			entity.baseDrawOffset = center.multiply(new Vector2(t, t)).subtract(new Vector2(0, sin(pi * t) * h));
		}
	});
}