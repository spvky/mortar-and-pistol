package main

import "core:c"
import rl "vendor:raylib"

model: rl.Model
input_buffer: InputBuffer
world: World
screen_texture: rl.RenderTexture
run: bool


init :: proc() {
	run = true
	when ODIN_OS == .Darwin {
		rl.SetConfigFlags({.WINDOW_HIGHDPI})
	}
	rl.InitWindow(1600, 900, "name")
	screen_texture = rl.LoadRenderTexture(800, 450)
	world = make_world()
	check := load_texture("assets/textures/checkerboard.png")
	model = rl.LoadModelFromMesh(rl.GenMeshCube(256, 1, 256))
	model.materials[0].maps[0].texture = check
}

update :: proc() {
	render_scene()
	draw_to_screen()
}

shutdown :: proc() {
	rl.UnloadRenderTexture(screen_texture)
	rl.CloseWindow()
}

should_run :: proc() -> bool {
	when ODIN_OS != .JS {
		run = !rl.WindowShouldClose()
	}
	return run
}

parent_window_size_changed :: proc(w, h: int) {
	rl.SetWindowSize(c.int(w), c.int(h))
}
