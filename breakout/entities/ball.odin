package entities

import rl "vendor:raylib"

BALL_RADIUS :: 20
BALL_COLOR :: rl.RED

Ball :: struct {
	pos, dir:   rl.Vector2,
	base_speed: f32,
	speed_mod:  f32,
}
