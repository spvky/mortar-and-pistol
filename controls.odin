package main

InputBuffer :: struct {
	buffered_inputs: [Action]f32,
	buffer_length: f32,
}

Action :: enum {
	LShoot,
	RShoot,
	Roll,
	Jump,
}

buffer_action :: proc(action: Action) {
	input_buffer.buffered_inputs[action] = input_buffer.buffer_length
}

is_action_buffered :: proc(action: Action) -> bool {
	return input_buffer.buffered_inputs[action] > 0
}

consume_action :: proc(action: Action) {
	input_buffer.buffered_inputs[action] = 0
}

update_buffer :: proc(delta: f32) {
	for &action in input_buffer.buffered_inputs {
		if action > 0 {
			action -= delta
		}
		if action < 0 {
			action = 0
		}
	}
}
