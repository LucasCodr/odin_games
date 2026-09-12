package main

import "./game"
import "./renderer"
import rl "vendor:raylib"

WALL_THICKNESS: f32 : 20
WALL_COLOR :: rl.BROWN

main :: proc() {
	rl.SetTargetFPS(60)
	// Resizable will require recalculating the bricks...🥶
	// rl.SetConfigFlags({.WINDOW_RESIZABLE})
	rl.InitAudioDevice()
	rl.InitWindow(1280, 720, "Breakout")
	defer rl.CloseWindow()
	defer rl.CloseAudioDevice()

	ctx := game.make_game()
	defer game.exit_and_save(ctx)
	defer game.unload_assets(ctx)
	defer delete(ctx.bricks)

	for !rl.WindowShouldClose() {
		// update
		game.update(&ctx, rl.GetFrameTime())

		rl.BeginDrawing()
		defer rl.EndDrawing()
		rl.ClearBackground(rl.BLACK)

		renderer.draw(ctx)
	}
}
