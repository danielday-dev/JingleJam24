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

runTimer = 500;

playerPath = [];
combatEnemies = [];

level = 0;
lootIsMagic = false;
loot = undefined;

bossAttackTime = 42;


// Level board setup.
var boardSize = 5;
tiles = [];
GameState_generateLevel(10, 5);