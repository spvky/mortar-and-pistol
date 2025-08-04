package main

import "core:fmt"
import m "core:math"
import l "core:math/linalg"
import rl "vendor:raylib"

Camera :: struct {
	using raw:        rl.Camera3D,
	look_sensitivity: f32,
	pitch:            f32,
	yaw:              f32,
	forward:          Vec3,
	right:            Vec3,
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

	forward := l.normalize(
		Vec3 {
			m.cos(camera.yaw) * m.cos(camera.pitch),
			m.sin(camera.pitch),
			m.sin(camera.yaw) * m.cos(camera.pitch),
		},
	)
	right := l.normalize(l.cross(forward, Vec3{0, 1, 0}))


	camera.forward = forward
	camera.right = right
	// world.camera.position += forward * move_speed * movement_delta.z
	// world.camera.position += right * move_speed * movement_delta.x
	world.camera.target = camera.position + forward
}

interpolate_vector :: proc(vector: Vec3) {
	// if rl.IsKeyDown(.W) {
	// 	movement_delta.z += 1
	// }
	// if rl.IsKeyDown(.S) {
	// 	movement_delta.z -= 1
	// }
	// if rl.IsKeyDown(.A) {
	// 	movement_delta.x -= 1
	// }
	// if rl.IsKeyDown(.D) {
	// 	movement_delta.x += 1
	// }

	true_vec := (forward * vector.z) + (right * vector.x)
	true_vec.y = 0
	return l.normalize0(true_vec)

	// move_speed: f32 = frametime
	// camera.position += movement_vec * move_speed
}
