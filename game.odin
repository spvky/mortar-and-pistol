package main


import "core:c"
import "core:fmt"
import "core:math"
import rl "vendor:raylib"

TICK_RATE :: 1.0 / 200.0
model: rl.Model
input_buffer: InputBuffer
world: World
time: Time
screen_texture: rl.RenderTexture
run: bool

current_time: f32
previous_time: f32


init :: proc() {
	run = true
	when ODIN_OS == .Darwin {
		rl.SetConfigFlags({.WINDOW_HIGHDPI})
	}
	rl.InitWindow(1600, 900, "name")
	rl.DisableCursor()
	screen_texture = rl.LoadRenderTexture(800, 450)
	world = make_world()
	check := load_texture("assets/textures/checkerboard.png")
	model = rl.LoadModelFromMesh(rl.GenMeshCube(256, 1, 256))
	model.materials[0].maps[0].texture = check
}

update :: proc() {
	// time_step()
	update_camera()
	render_scene()
	draw_to_screen()
}

time_step :: proc() {
	frametime := rl.GetFrameTime()
	if !time.started {
		time.t = f32(rl.GetTime())
		time.started = true
	}
	t1 := f32(rl.GetTime())
	elapsed := math.min(t1 - time.t, 0.25)

	time.t = t1
	time.simulation_time += elapsed
	for time.simulation_time > TICK_RATE {
		// Behaviour goes here
		time.simulation_time -= TICK_RATE
	}
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
