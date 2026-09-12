package gameplay

import "core:math/linalg"
import rl "vendor:raylib"

import "../entities"

break_brick :: proc(
	bricks: ^[dynamic]entities.Brick,
	brick_index: int,
	ball: ^entities.Ball,
) -> bool {
	ball.dir.y = -ball.dir.y
	ball.speed_mod += 0.1
	unordered_remove(bricks, brick_index)
	return true
}

shorten_paddle :: proc(paddle: ^entities.Paddle) {
	paddle.width = paddle.width - paddle.width * 0.15
}

bounce_off_ceiling :: proc(ball: ^entities.Ball) {
	ball.dir.y = -ball.dir.y
}

bounce_off_wall :: proc(ball: ^entities.Ball) -> bool {
	ball.dir.x = -ball.dir.x
	return true
}

bounce_off_paddle :: proc(ball: ^entities.Ball, paddle: entities.Paddle) -> bool {
	// Prevents the ball from passing through the paddle before changing its direction
	if ball.dir.y > 0 {
		ball.pos.y = paddle.pos.y - entities.BALL_RADIUS
	} else {
		ball.pos.y = paddle.pos.y + entities.PADDLE_HEIGHT + entities.BALL_RADIUS
	}

	ball.dir.y = -ball.dir.y

	hit_offset := (ball.pos.x - (paddle.pos.x + paddle.width / 2)) / (paddle.width / 2)

	ball.dir.x = hit_offset
	ball.dir = linalg.vector_normalize0(ball.dir)

	return true
}
