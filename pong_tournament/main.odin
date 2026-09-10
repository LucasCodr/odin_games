package main

import "game"
import "renderer"

import rl "vendor:raylib"

main :: proc() {
	rl.SetTargetFPS(60)

	rl.InitWindow(1280, 720, "Pong Tournament")
	rl.InitAudioDevice()
	defer rl.CloseWindow()
	defer rl.CloseAudioDevice()

	ctx, event_queue := game.make_game()
	defer game.unload_assets(ctx.assets)

	for !rl.WindowShouldClose() {
		game.update(&ctx, &event_queue, rl.GetFrameTime())

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		defer rl.EndDrawing()

		renderer.draw_game(&ctx)
	}
}
