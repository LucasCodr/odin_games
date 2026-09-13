# Odin Games

Practice repo for learning game programming in [Odin](https://odin-lang.org/), working through the [20 Games Challenge](https://20_games_challenge.gitlab.io/).

The challenge is a deliberate path through small, complete games — each one a bit larger or more technical than the last — so fundamentals stick without jumping straight into a dream project.

## Stack

- **Language:** [Odin](https://odin-lang.org/)
- **Graphics / audio / input:** [raylib](https://www.raylib.com/) via Odin’s `vendor:raylib`
- **Approach:** one folder per game, built from scratch (no engine tutorials)

## Challenge roadmap

The curated starter list pairs alternatives at each step — pick one game per slot. Full definitions of done live on the [challenge page](https://20_games_challenge.gitlab.io/challenge/).

| Step | Options | Focus |
| ---- | ------- | ----- |
| 1 | Pong · Flappy Bird | Engine basics, input, collisions |
| 2 | Breakout · Jetpack Joyride | Reuse, scoring, sound, persistence |
| 3 | Space Invaders · Frogger · River Raid | Art, animation, particles, juice |
| 4 | Asteroids · Spacewar! · Indy 500 | More complex motion / arenas |
| 5 | Pac-Man · Tic-Tac-Toe · Conway's Game of Life | Grids, AI / rules, turn-based or cellular |
| 6 | Super Mario Bros. · Pitfall · VVVVVV | Platforming, levels, camera |
| 7 | Worms · Dig Dug | Terrain deformation, turn systems |
| 8 | Super Monkey Ball · Star Fox · Crash Bandicoot | 3D movement and cameras |
| 9 | Doom · Mario Kart | FPS or racing fundamentals |
| 10 | Minecraft · Portal | Bigger systems (voxels / puzzles) |

After ~10 games, the challenge opens up: pick projects that match a personal goal, then finish with a polished capstone.

## Running a game

Requires the [Odin compiler](https://odin-lang.org/docs/install/) on your `PATH`.

```bash
cd game
odin run .
```

## House rules

1. **No full tutorials** — look up specific questions freely; don’t follow a step-by-step clone guide.
2. **No AI implementations** — don’t have AI write the game (or large chunks of it). Asking specific questions is fine; the point is to learn by doing the work yourself.
3. **Timebox** — finish and move on (roughly ~20 hours early on is a good default).
4. **Stay flexible** — substitute games when something teaches the next skill better.

Challenge rules detail: [How it Works](https://20_games_challenge.gitlab.io/how/).

## Links

- [20 Games Challenge](https://20_games_challenge.gitlab.io/)
- [Curated challenge list](https://20_games_challenge.gitlab.io/challenge/)
- [Master game list](https://20_games_challenge.gitlab.io/games/)
- [Odin language](https://odin-lang.org/)
- [raylib](https://www.raylib.com/)
