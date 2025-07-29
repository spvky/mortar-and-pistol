package main

import rl "vendor:raylib"

world: World
screen_texture: rl.RenderTexture
run: bool

main :: proc() {
	init()
	for should_run() {
		update()
	}
	shutdown()
}
