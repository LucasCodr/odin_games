package game

import "../entities"
import "../save"

import rl "vendor:raylib"

WallSide :: enum {
	LEFT,
	RIGHT,
}

GRID_GAP :: 5

make_bricks :: proc() -> [dynamic]entities.Brick {
	rows := 8
	columns := 10
	total_bricks := rows * columns

	available_space := (f32(rl.GetScreenWidth()) - entities.WALL_WIDTH * 2)
	brick_width := (available_space - f32(columns + 1) * GRID_GAP) / f32(columns)
	bricks := make([dynamic]entities.Brick, total_bricks, total_bricks)

	x := entities.WALL_WIDTH + GRID_GAP
	y := entities.CEILING_HEIGHT + GRID_GAP

	for i in 0 ..< total_bricks {
		hue := f32(rl.GetRandomValue(0, 360))

		bricks[i] = entities.Brick {
			{x = x, y = y, width = brick_width, height = entities.BRICK_HEIGHT},
			rl.ColorFromHSV(hue, 0.75, 0.95),
		}

		x += brick_width + GRID_GAP

		if (i + 1) % columns == 0 {
			x = f32(entities.WALL_WIDTH) + GRID_GAP
			y += entities.BRICK_HEIGHT + GRID_GAP
		}
	}

	return bricks
}

make_wall :: proc(side: WallSide) -> entities.Wall {
	x: f32 = 0 if side == .LEFT else f32(rl.GetScreenWidth()) - entities.WALL_WIDTH
	h := f32(rl.GetScreenHeight())
	return {y = 0, x = x, height = h, width = entities.WALL_WIDTH}
}

make_ceiling :: proc() -> entities.Ceiling {
	w := f32(rl.GetScreenWidth()) - entities.WALL_WIDTH * 2

	return {x = entities.WALL_WIDTH, y = 0, width = w, height = entities.CEILING_HEIGHT}
}

make_paddle :: proc() -> entities.Paddle {
	center_x := f32(rl.GetScreenWidth()) / 2 - entities.INITIAL_PADDLE_WIDTH / 2
	bottom := f32(rl.GetScreenHeight()) - entities.PADDLE_HEIGHT

	return entities.Paddle{{center_x, bottom}, 0, entities.INITIAL_PADDLE_WIDTH}
}

make_ball :: proc(speed_mod: f32 = 1) -> entities.Ball {
	center_x := f32(rl.GetScreenWidth()) / 2
	paddle_top := f32(rl.GetScreenHeight()) - entities.PADDLE_HEIGHT - entities.BALL_RADIUS

	return entities.Ball {
		base_speed = 200,
		speed_mod = speed_mod,
		dir = {0, -1},
		pos = {center_x, paddle_top - 1},
	}
}

make_assets :: proc() -> Assets {
	return {
		break_sfx = rl.LoadSound("assets/break.ogg"),
		bounce = rl.LoadSound("assets/bounce.ogg"),
		impact = rl.LoadSound("assets/impact.wav"),
	}
}

make_game :: proc() -> GameContext {
	save_state, _ := save.load()

	return GameContext {
		score = 0,
		lives = 3,
		paddle = make_paddle(),
		ceiling = make_ceiling(),
		walls = {make_wall(.LEFT), make_wall(.RIGHT)},
		ball = make_ball(),
		bricks = make_bricks(),
		assets = make_assets(),
		save = save_state,
	}
}

unload_assets :: proc(ctx: GameContext) {
	rl.UnloadSound(ctx.assets.bounce)
	rl.UnloadSound(ctx.assets.break_sfx)
	rl.UnloadSound(ctx.assets.impact)
}

exit_and_save :: proc(ctx: GameContext) {
	if ctx.score > ctx.save.highest_score {
		save.write({highest_score = ctx.score})
	}
}
