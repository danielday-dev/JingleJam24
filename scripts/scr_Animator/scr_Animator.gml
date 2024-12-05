function Animator_dispatch(_animationInformation){
	with (obj_animator) {
		animationList[array_length(animationList)] = _animationInformation;
	}
}
function Animator_isActive(){
	with (obj_animator) {
		return array_length(animationList) > 0;		
	}
	return false;
}