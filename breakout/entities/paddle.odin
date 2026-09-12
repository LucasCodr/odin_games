package entities

import rl "vendor:raylib"

INITIAL_PADDLE_WIDTH :: 150
PADDLE_HEIGHT :: 20

Paddle :: struct {
	pos:   rl.Vector2,
	vel:   f32,
	width: f32,
}
