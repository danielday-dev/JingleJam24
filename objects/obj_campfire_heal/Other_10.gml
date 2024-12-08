obj_campfire_manager.healed = true;

obj_player.entityHealth = min(obj_player.entityHealth + healAmount, obj_player.entityHealthMax);
GameState_consumeTime(timeCost);