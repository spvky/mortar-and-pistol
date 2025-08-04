package main

import "core:fmt"
import m "core:math"
import l "core:math/linalg"
import rl "vendor:raylib"

Camera :: struct {
	using raw:        rl.Camera3D,
	pitch:            f32,
	yaw:              f32,
	look_sensitivity: f32,
}

update_camera :: proc() {
	frametime := rl.GetFrameTime()
	camera := &world.camera
	delta := rl.GetMouseDelta()
	min: f32 = -90
	max: f32 = 90
	camera.yaw += (delta.x * camera.look_sensitivity * frametime)
	camera.pitch = l.clamp(
		camera.pitch - (delta.y * camera.look_sensitivity * frametime),
		min,
		max,
	)
	// pitch: f32 = l.to_radians(
	// 	l.clamp(l.to_degrees(camera.pitch - (delta.y * 500 * frametime)), -60, 60),
	// )

	forward := l.normalize(
		Vec3 {
			m.cos(camera.yaw) * m.cos(camera.pitch),
			m.sin(camera.pitch),
			m.sin(camera.yaw) * m.cos(camera.pitch),
		},
	)
	right := l.normalize(l.cross(forward, Vec3{0, 1, 0}))


	movement_delta: Vec3

	if rl.IsKeyDown(.W) {
		movement_delta.z += 1
	}
	if rl.IsKeyDown(.S) {
		movement_delta.z -= 1
	}
	if rl.IsKeyDown(.A) {
		movement_delta.x -= 1
	}
	if rl.IsKeyDown(.D) {
		movement_delta.x += 1
	}

	movement_delta = l.normalize0(movement_delta)

	move_speed: f32 = frametime
	world.camera.position += forward * move_speed * movement_delta.z
	world.camera.position += right * move_speed * movement_delta.x
	world.camera.target = camera.position + forward
}
