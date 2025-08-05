package main

Collider :: struct {
	tag:         EnvironmentTag,
	translation: Vec3,
	extents:     Vec3,
}

EnvironmentTag :: enum {
	Floor,
	Fence,
	Ceiling,
	Wall,
	Gate,
}
