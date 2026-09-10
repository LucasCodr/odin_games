package game

import "../entities"
import rl "vendor:raylib"

Event :: union {
	entities.ScoreEvent,
	entities.GameOverEvent,
}

EventQueue :: struct {
	events: [dynamic]Event,
}

process_events :: proc(q: ^EventQueue, ctx: ^Game_Context) {
	for e in q.events {
		switch event in e {
		case entities.ScoreEvent:
			rl.PlaySound(ctx.assets.scored)
			if event.side == .LEFT {
				ctx.scoreboard.opponent += 1
			} else {
				ctx.scoreboard.player += 1
			}
			ctx.ball = make_ball()
		case entities.GameOverEvent:
			ctx.state = .MENU
			ctx.ball = make_ball()
			ctx.player = make_player()
		}
	}

	clear(&q.events)
}

emit_score :: proc(q: ^EventQueue, side: entities.BallLostSide) {
	append(&q.events, entities.ScoreEvent{side = side})
}

emit_game_over :: proc(q: ^EventQueue, winner: entities.Paddle) {
	append(&q.events, entities.GameOverEvent{})
}
