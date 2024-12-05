function Animator_dispatch(_totalSeconds, _type, _interpolation, _args){
	with (obj_animator) {
		animationList[array_length(animationList)] = new AnimationInformation(
			_totalSeconds, _type, _interpolation, _args
		);
	}
}
function Animator_isActive(){
	with (obj_animator) {
		return array_length(animationList) > 0;		
	}
	return false;
}