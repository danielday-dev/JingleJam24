enum GameState {
	Level,
	Combat,
	Campfire,
};
currentGameState = GameState.Level;
targetGameState = currentGameState;

// Player setup.
random_set_seed(get_timer());

// Level board setup.
var boardSize = 5;
tiles = [];
GameState_generateLevel(boardSize * 2, boardSize);

runTimer = 600;

playerPath = [];
combatEnemies = [ ];