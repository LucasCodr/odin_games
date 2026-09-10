package game

import "../entities"

Game_State :: enum {
	MENU,
	PLAYING,
	PAUSED,
}

Score_Board :: struct {
	player:   u8,
	opponent: u8,
}

Game_Context :: struct {
	ball:       entities.Ball,
	player:     entities.Paddle,
	opponent:   entities.Paddle,
	state:      Game_State,
	scoreboard: Score_Board,
	assets:     Assets,
}
