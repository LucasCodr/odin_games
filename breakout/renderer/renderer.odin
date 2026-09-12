package renderer

import "../entities"
import "../game"

import rl "vendor:raylib"

draw :: proc(ctx: game.GameContext) {
	draw_paddle(ctx.paddle)
	draw_ceiling(ctx.ceiling)
	draw_ball(ctx.ball)

	for wall in ctx.walls {
		draw_wall(wall)
	}

	for brick in ctx.bricks {
		draw_brick(brick)
	}

	draw_stats(ctx.score, ctx.lives, ctx.save.highest_score)
}

draw_stats :: proc(score, lives, highest: int) {
	text := rl.TextFormat("Score: %d | Lives: %d | Highest score: %d", score, lives, highest)
	rl.DrawText(text, 10, 7, 30, rl.WHITE)
}

draw_brick :: proc(brick: entities.Brick) {
	rl.DrawRectangleRec(brick.rect, brick.color)
}

draw_paddle :: proc(paddle: entities.Paddle) {
	rl.DrawRectangleV(paddle.pos, {paddle.width, entities.PADDLE_HEIGHT}, rl.BLUE)
}

draw_ceiling :: proc(ceiling: entities.Ceiling) {
	rl.DrawRectangleRec(ceiling, entities.CEILING_COLOR)
}

draw_wall :: proc(wall: entities.Wall) {
	h := f32(rl.GetScreenHeight())
	rl.DrawRectangleRec(wall, entities.WALL_COLOR)
}

draw_ball :: proc(ball: entities.Ball) {
	rl.DrawCircleV(ball.pos, entities.BALL_RADIUS, entities.BALL_COLOR)
}
