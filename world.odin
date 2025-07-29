package main

import rl "vendor:raylib"

World :: struct {
	camera: rl.Camera,
}

make_world :: proc() -> World {
	return World{camera = rl.Camera3D{position = {10, 10, -10}, up = {0, 1, 0}, fovy = 45}}
}
