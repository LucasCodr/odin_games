package entities

import rl "vendor:raylib"

BRICK_HEIGHT :: 20

Brick :: struct {
	rect:  rl.Rectangle,
	color: rl.Color,
}
