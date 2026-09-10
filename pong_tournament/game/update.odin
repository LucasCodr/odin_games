package game

import "../collisions"
import "../entities"
import "../input"
import rl "vendor:raylib"

update_paddle :: proc(paddle: ^entities.Paddle, input: input.Paddle_Input, dt: f32) {
	direction: f32 = 0.0

	if input.up {
		direction -= 1
	}

	if input.down {
		direction += 1
	}

	paddle.vel = direction * 400
	paddle.pos.y += paddle.vel * dt
	paddle.pos.y = clamp(paddle.pos.y, 0, f32(rl.GetScreenHeight()) - entities.PADDLE_HEIGHT)
}

update_ball :: proc(ball: ^entities.Ball, dt: f32, assets: Assets) -> entities.BallLostSide {
	if ball.pos.y < entities.BALL_RADIUS ||
	   ball.pos.y > f32(rl.GetScreenHeight()) - entities.BALL_RADIUS {
		ball.vel.y = -ball.vel.y
		rl.PlaySound(assets.pong)
	}

	ball.pos += ball.vel * dt

	if ball.pos.x > f32(rl.GetScreenWidth()) {
		return .RIGHT
	}

	if ball.pos.x < 0 {
		return .LEFT
	}

	return .None
}

update_opponent :: proc(ball: entities.Ball, paddle: ^entities.Paddle, dt: f32) {
	target_y := ball.pos.y - entities.PADDLE_HEIGHT / 2
	diff := target_y - paddle.pos.y

	max_speed: f32 = 400

	switch paddle.mode {
	case .EASY:
	case .NORMAL:
		max_speed = 600
	case .HARD:
		max_speed = 900
	}

	paddle.vel = clamp(diff * (5 if paddle.mode == .NORMAL else 8), -max_speed, max_speed)
	paddle.pos.y += paddle.vel * dt
}

update :: proc(game: ^Game_Context, event_queue: ^EventQueue, dt: f32) {
	switch game.state {
	case .MENU:
	case .PLAYING, .PAUSED:
		dt: f32 = 0 if game.state == .PAUSED else dt

		player_input := input.read_player_input()
		update_paddle(&game.player, player_input, dt)
		score_side := update_ball(&game.ball, dt, game.assets)

		update_opponent(game.ball, &game.opponent, dt)

		if collisions.resolve_ball_paddle(&game.ball, game.player) {
			rl.PlaySound(game.assets.ping)
		}

		if collisions.resolve_ball_paddle(&game.ball, game.opponent) {
			rl.PlaySound(game.assets.ping)
		}

		if input.read_pause_input() {
			if game.state == .PAUSED {
				game.state = .PLAYING
			} else {
				game.state = .PAUSED
			}
		}

		if score_side != .None {
			emit_score(event_queue, score_side)
		}
	}


	process_events(event_queue, game)
}
