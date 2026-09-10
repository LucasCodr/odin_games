package game

import rl "vendor:raylib"

Assets :: struct {
	ping:   rl.Sound,
	pong:   rl.Sound,
	scored: rl.Sound,
}

load_assets :: proc() -> Assets {
	return {
		ping = rl.LoadSound("assets/ping.ogg"),
		pong = rl.LoadSound("assets/pong.ogg"),
		scored = rl.LoadSound("assets/scored.wav"),
	}
}

unload_assets :: proc(assets: Assets) {
	rl.UnloadSound(assets.ping)
	rl.UnloadSound(assets.pong)
	rl.UnloadSound(assets.scored)
}
