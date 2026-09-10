package collision

import "../entities"
import rl "vendor:raylib"

resolve_ball_paddle :: proc(ball: ^entities.Ball, paddle: entities.Paddle) -> bool {
	paddle_rect := rl.Rectangle {
		paddle.pos.x,
		paddle.pos.y,
		entities.PADDLE_WIDTH,
		entities.PADDLE_HEIGHT,
	}

	if rl.CheckCollisionCircleRec(ball.pos, entities.BALL_RADIUS, paddle_rect) {
		// Prevents the ball from passing through the paddle before changing its direction
		if ball.vel.x > 0 {
			ball.pos.x = paddle.pos.x - entities.BALL_RADIUS
		} else {
			ball.pos.x = paddle.pos.x + entities.PADDLE_WIDTH + entities.BALL_RADIUS
		}

		ball.vel.x = -ball.vel.x

		hit_offset :=
			(ball.pos.y - (paddle.pos.y + entities.PADDLE_HEIGHT / 2)) /
			(entities.PADDLE_HEIGHT / 2)

		ball.vel.y = hit_offset * 400

		return true
	}

	return false
}
