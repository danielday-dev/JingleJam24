/// @description Stars.

var _portions		= [ 4, 2.25, 1, 5, 4, 0.1 ];
var _screenShake	= [ 1, 2,	 3, 8, 0, 0 ];

var totalPortionTime = 0;
for (var i = 0; i < array_length(_portions); i++)
	totalPortionTime += _portions[i];

Animator_dispatch(totalPortionTime, AnimationType.Custom, AnimationInterpolation.Linear, {
	entity: obj_enemy_chronos.id,
	target: obj_player.id,
	damage: 40,
	timeMultiplier: totalPortionTime,
	screenShake: _screenShake,
	portions: array_concat([ 0 ], _portions),
	lastPortion: -1,
	func: function(_t, _args) {
		var time = _t * _args.timeMultiplier;
		var currentPortion = 0;
		while (currentPortion + 1 < array_length(_args.portions) &&	
			_args.portions[currentPortion + 1] < time) {
			currentPortion++;
			time -= _args.portions[currentPortion];
		}
		
		shakeScreen(_args.screenShake[currentPortion]);
		
		if (_args.lastPortion == currentPortion) return;
		_args.lastPortion = currentPortion;
		
		var enemyCenter = new Vector2(350, 150);
		var playerCenter = new Vector2(250, 250);
		
		switch (currentPortion) {
			case 0: {
				Stars_orbitTarget(enemyCenter, 10, 20, 2);
			} break;
			case 1: {
				Stars_orbitTarget(enemyCenter, -70, -80, 2);
			} break;
			case 2: {
				Stars_orbitTarget(playerCenter, 70, 80, 2);
			} break;
			case 3: {
				Stars_orbitTarget(playerCenter, 70, 80, 2);
			} break;
			case 4: {
				Combat_damageEntity(_args.target, 30);
				Stars_orbitTarget(playerCenter, -50, -70, 2);
			} break;
			case 5: {
				Stars_reset();
				obj_enemy_chronos.entityTurnTimer = 12;
				obj_gameStateManager.runTimer = obj_gameStateManager.bossAttackTime;
			} break;
		}
		
	}
});








