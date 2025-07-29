package main

InputBuffer :: struct {
	buffered_inputs: [Action]f32,
	buffer_length: f32
}

Action :: enum {
	LShoot,
	RShoot,
	Roll,
	Jump
}

buffer_action :: proc(action: Action) {
	using input_buffer
	buffered_inputs[action] = buffer_length
}

is_action_buffered :: proc(action: Action) -> bool {
	using input_buffer
	return buffered_inputs[action] > 0
}

consume_action :: proc(action: Action) {
	using input_buffer
	buffered_inputs[action] = 0
}

update_buffer :: proc(delta: f32) {
	using input_buffer
	for &action in buffered_inputs {
		if action > 0 {
			action -= delta
		}
		if action < 0 {
			action = 0
		}
	}
}
