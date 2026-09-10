package entities

import rl "vendor:raylib"

PADDLE_WIDTH :: 20.0
PADDLE_HEIGHT :: 100.0

Paddle_Opponent_Mode :: enum {
	EASY,
	NORMAL,
	HARD,
}

Paddle :: struct {
	pos:         rl.Vector2,
	vel:         f32,
	is_opponent: bool,
	mode:        Paddle_Opponent_Mode,
}

GameOverEvent :: struct {}
