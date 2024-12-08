function Stars_bringToDepth(_depth) {
	with (obj_star) {
		depth = _depth;
	}	
}

function Stars_orbitTarget(_origin, _orbitAngleMin, _orbitAngleMax, _orbitSpeed = 2) {
	obj_starManager.originTarget = _origin;
	with (obj_star) {
		dist = random_range(_orbitAngleMin, _orbitAngleMax);	
		speed = _orbitSpeed;
	}	
}

function Stars_reset() {
	obj_starManager.originTarget.x = -1;
	with (obj_star) {
		visible = false;
		returnHome = true;
	}	
}