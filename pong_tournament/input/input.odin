package input

import rl "vendor:raylib"

Paddle_Input :: struct {
	up:   bool,
	down: bool,
}

read_player_input :: proc() -> Paddle_Input {
	return Paddle_Input{up = rl.IsKeyDown(.UP), down = rl.IsKeyDown(.DOWN)}
}

read_pause_input :: proc() -> bool {
	return rl.IsKeyPressed(.P)
}
