enum AnimationType {
	Position,
	Custom,
	GUIFade, BackgroundFade,
};
enum AnimationInterpolation {
	Linear,
	Square,
	Ease,
	EaseIn,
	EaseOut,
	EaseSine,
	EaseInSine,
	EaseOutSine,
};

function AnimationInformation(_totalSeconds, _type, _interpolation, _args) constructor {
	time = 0.0;
	timeDelta = 1.0 / _totalSeconds;
	
	type = _type;
	interpolation = _interpolation;
	args = _args;
	
	static hasAllArgs = function(_argsList) {
		var len = array_length(_argsList);
		for (var i = 0; i < len; i++)
			if (!struct_exists(args, _argsList[i]))
				return false;
		return true;
	}
	
	switch (type) {
		case AnimationType.GUIFade: args.startFade = obj_fader_gui.fadeAmount; break;
		case AnimationType.BackgroundFade: args.startFade = obj_fader_background.fadeAmount; break;
	}
	
	static update = function() {
		switch (type) {
			case AnimationType.Position: {
				if (!hasAllArgs([ "target", "startPos", "endPos" ])) break;

				var pStart = args.startPos, pEnd = args.endPos;
				var pos = pStart.interpolate(pEnd, getTime());
				with (args.target) {	
					x = pos.x;
					y = pos.y;
				}
			} break;
			case AnimationType.Custom: {
				if (!hasAllArgs([ "func" ])) break;
				args.func(getTime(), args);
			} break;
			case AnimationType.GUIFade:
			case AnimationType.BackgroundFade: {
				if (!hasAllArgs([ "fade", "startFade" ])) break;
				var fade = lerp(args.startFade, args.fade, getTime());
				switch (type) {
					case AnimationType.GUIFade: obj_fader_gui.fadeAmount = fade; break;
					case AnimationType.BackgroundFade: obj_fader_background.fadeAmount = fade; break;
				}
			} break;
		}
	}
	static tick = function(_time) {
		time += timeDelta  * _time;
		if (time > 1.0) {
			time = 1.0;
			timeDelta  = 0.0;
		}
		update();
	}
	
	static getTime = function() {
		switch (interpolation) {
			case AnimationInterpolation.Square: return square(time);
			case AnimationInterpolation.Ease: return ease(time);
			case AnimationInterpolation.EaseIn: return ease_in(time);
			case AnimationInterpolation.EaseOut: return ease_out(time);
			case AnimationInterpolation.EaseSine: return ease_sin(time);
			case AnimationInterpolation.EaseInSine: return ease_in_sin(time);
			case AnimationInterpolation.EaseOutSine: return ease_out_sin(time);
		}
		return time;
	}
	
	static hasCompleted = function() {
		return time >= 1.0;	
	}
}