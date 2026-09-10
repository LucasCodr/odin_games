package renderer

import "../entities"
import "../game"
import "core:fmt"
import "core:os"
import "core:strings"
import rl "vendor:raylib"

draw_paddle :: proc(paddle: entities.Paddle) {
	rl.DrawRectangleV(paddle.pos, {entities.PADDLE_WIDTH, entities.PADDLE_HEIGHT}, rl.RED)
}

draw_ball :: proc(ball: entities.Ball) {
	rl.DrawCircleV(ball.pos, entities.BALL_RADIUS, rl.WHITE)
}

draw_menu :: proc(ctx: ^game.Game_Context) {
	font_size: i32 = 40
	gap: i32 = 40
	title := rl.TextFormat("Pong Tournament")
	title_width := rl.MeasureText(title, font_size)

	rl.DrawText(
		title,
		rl.GetScreenWidth() / 2 - title_width / 2,
		rl.GetScreenHeight() / 2 - gap,
		font_size,
		rl.WHITE,
	)

	btn_width: f32 = 100
	btn_height: f32 = 30

	button_rect := rl.Rectangle {
		x      = f32(rl.GetScreenWidth() / 2) - btn_width / 2,
		y      = f32(rl.GetScreenHeight() / 2) + f32(gap),
		width  = btn_width,
		height = btn_height,
	}

	if rl.GuiButton(button_rect, "Play!") {
		ctx.state = .PLAYING
	}

	rl.GuiComboBox(
		rl.Rectangle {
			f32(rl.GetScreenWidth() / 2) - btn_width / 2,
			f32(rl.GetScreenHeight() / 2) + f32(gap * 2),
			btn_width,
			btn_height,
		},
		"Easy;Normal;Hard",
		cast(^i32)&ctx.opponent.mode,
	)
}

SCORE_FONT_SIZE :: 40

draw_score :: proc(scoreboard: game.Score_Board) {
	player_score_str := rl.TextFormat("%d - %d", scoreboard.player, scoreboard.opponent)
	text_width := rl.MeasureText(player_score_str, SCORE_FONT_SIZE)

	rl.DrawText(
		player_score_str,
		rl.GetScreenWidth() / 2 - text_width / 2,
		0,
		SCORE_FONT_SIZE,
		rl.RED,
	)
}

draw_game :: proc(ctx: ^game.Game_Context) {
	#partial switch ctx.state {
	case .MENU:
		draw_menu(ctx)
	case .PLAYING, .PAUSED:
		draw_score(ctx.scoreboard)
		draw_paddle(ctx.player)
		draw_paddle(ctx.opponent)
		draw_ball(ctx.ball)
	}
}
