package game

import "../entities"
import rl "vendor:raylib"

make_ball :: proc() -> entities.Ball {
	center_x := f32(rl.GetScreenWidth()) / 2 - entities.BALL_RADIUS
	center_y := f32(rl.GetScreenHeight()) / 2

	return {{center_x, center_y}, {-400, 0}}
}

make_player :: proc() -> entities.Paddle {
	center_y := f32(rl.GetScreenHeight()) / 2 - entities.PADDLE_HEIGHT / 2

	return entities.Paddle{pos = {0, center_y}, vel = 0}
}

make_game :: proc() -> (Game_Context, EventQueue) {
	center_x := f32(rl.GetScreenWidth()) / 2
	center_y := f32(rl.GetScreenHeight()) / 2
	right := f32(rl.GetScreenWidth()) - entities.PADDLE_WIDTH

	event_queue := EventQueue{}

	return Game_Context {
			state = .MENU,
			ball = make_ball(),
			player = make_player(),
			opponent = entities.Paddle {
				pos = {right, center_y - entities.PADDLE_HEIGHT / 2},
				vel = 0,
				is_opponent = true,
				mode = .NORMAL,
			},
			assets = load_assets(),
		},
		event_queue
}
