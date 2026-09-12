package game

import "../entities"
import "../save"

import rl "vendor:raylib"

Assets :: struct {
	break_sfx: rl.Sound,
	bounce:    rl.Sound,
	impact:    rl.Sound,
}

GameContext :: struct {
	score:   int,
	lives:   int,
	paddle:  entities.Paddle,
	walls:   [2]entities.Wall,
	ceiling: entities.Ceiling,
	ball:    entities.Ball,
	bricks:  [dynamic]entities.Brick,
	assets:  Assets,
	save:    save.Save,
}
