event_inherited();

if (Animator_isActive()) return;

switch (stage) {
	case 1: {  
		obj_gameStateManager.targetGameState = GameState.Level;
		Animator_dispatch(1.0, AnimationType.GUIFade, AnimationInterpolation.Ease, { fade: 1.0 });
		stage = 2;
	} break;	
	case 2: {  
		setGUIVisibility("Exit", false); 
		GameState_generateLevel(10, 5);
		Animator_dispatch(1.0, AnimationType.GUIFade, AnimationInterpolation.Ease, { fade: 0.0 });
		stage = 0;
	} break;	
}