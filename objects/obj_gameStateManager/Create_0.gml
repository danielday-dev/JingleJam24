draw_set_font(fnt_maki);

enum GameState {
	Level,
	Combat,
	Campfire,
	Loot,
	Exit,
};
currentGameState = GameState.Level;
targetGameState = currentGameState;

// Player setup.
random_set_seed(get_timer());

// Level board setup.
var boardSize = 5;
tiles = [];
GameState_generateLevel(10, 5);

runTimer = 1;

playerPath = [];
combatEnemies = [ ];