package entities

import rl "vendor:raylib"

BALL_RADIUS :: 20

Ball :: struct {
	pos: rl.Vector2,
	vel: rl.Vector2,
}

BallLostSide :: enum {
	None,
	LEFT,
	RIGHT,
}

ScoreEvent :: struct {
	side: BallLostSide,
}
