package main

import rl "vendor:raylib"

World :: struct {
	camera: Camera,
}

make_world :: proc() -> World {
	return World {
		camera = Camera {
			position = {10, 10, -10},
			up = {0, 1, 0},
			fovy = 45,
			look_sensitivity = 10,
		},
	}
}
