package collisions

import "../entities"
import rl "vendor:raylib"

check_ball_rect :: proc(ball: entities.Ball, rect: rl.Rectangle) -> bool {
	return rl.CheckCollisionCircleRec(ball.pos, entities.BALL_RADIUS, rect)
}

check_ball_paddle :: proc(ball: entities.Ball, paddle: entities.Paddle) -> bool {
	rect := rl.Rectangle {
		x      = paddle.pos.x,
		y      = paddle.pos.y,
		width  = paddle.width,
		height = entities.PADDLE_HEIGHT,
	}

	return rl.CheckCollisionCircleRec(ball.pos, entities.BALL_RADIUS, rect)
}
