package main


main :: proc() {
	init()
	if should_run() {
		update()
	}
	shutdown()
}
