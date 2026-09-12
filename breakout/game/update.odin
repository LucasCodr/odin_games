package game

import "../collisions"
import "../entities"
import "../gameplay"

import rl "vendor:raylib"

update :: proc(ctx: ^GameContext, dt: f32) {
	update_paddle(&ctx.paddle, dt)
	if offscreen := update_ball(&ctx.ball, dt); offscreen {
		ctx.ball = make_ball()
		ctx.paddle = make_paddle()
		ctx.lives -= 1
	}

	if collisions.check_ball_rect(ctx.ball, ctx.ceiling) {
		gameplay.bounce_off_ceiling(&ctx.ball)
		gameplay.shorten_paddle(&ctx.paddle)
	}

	if collisions.check_ball_paddle(ctx.ball, ctx.paddle) {
		if gameplay.bounce_off_paddle(&ctx.ball, ctx.paddle) {
			rl.PlaySound(ctx.assets.bounce)
		}
	}

	for wall in ctx.walls {
		if collisions.check_ball_rect(ctx.ball, wall) {
			if gameplay.bounce_off_wall(&ctx.ball) {
				rl.PlaySound(ctx.assets.impact)
			}
		}
	}

	// Only one brick per frame. A centered ball can overlap two bricks in a
	// column gap; handling both would flip dir.y twice and cancel the bounce.
	for brick, i in ctx.bricks {
		if collisions.check_ball_rect(ctx.ball, brick.rect) {
			if gameplay.break_brick(&ctx.bricks, i, &ctx.ball) {
				ctx.score += 1
				rl.PlaySound(ctx.assets.break_sfx)
			}
			break
		}
	}

	if ctx.lives <= 0 {
		clear(&ctx.bricks)
		ctx.score = 0
		ctx.lives = 3
		ctx.bricks = make_bricks()
		ctx.ball = make_ball()
		ctx.paddle = make_paddle()
	}
}

update_paddle :: proc(paddle: ^entities.Paddle, dt: f32) {
	direction: f32 = 0

	if rl.IsKeyDown(.RIGHT) {
		direction += 1
	}

	if rl.IsKeyDown(.LEFT) {
		direction -= 1
	}

	paddle.vel = direction * 500
	paddle.pos.x += paddle.vel * dt

	max_x := f32(rl.GetScreenWidth()) - (paddle.width + entities.WALL_WIDTH)
	paddle.pos.x = clamp(paddle.pos.x, entities.WALL_WIDTH, max_x)
}

update_ball :: proc(ball: ^entities.Ball, dt: f32) -> (offscreen: bool) {
	current_speed := ball.base_speed * ball.speed_mod

	ball.pos += ball.dir * current_speed * dt

	return ball.pos.y > f32(rl.GetScreenHeight()) - entities.BALL_RADIUS
}
