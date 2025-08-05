package main

import l "core:math/linalg"

Simplex :: struct {
	a:     Vec3,
	b:     Vec3,
	c:     Vec3,
	d:     Vec3,
	count: int,
}

Capsule :: struct {
	translation: Vec3,
	radius:      f32,
	height:      f32,
}

Sphere :: struct {
	translation: Vec3,
	radius:      f32,
}

gjk :: proc(
	s1: $T,
	s2: $V,
	c1, c2: Vec3,
) where (T == Capsule || T == Sphere || T == []Vec3) &&
	(V == Capsule || V == Sphere || V == []Vec3) {
	d := c2 - c1
	a := support(s1, s2, d)
	dir = -a
}

support :: proc(
	s1: $T,
	s2: $V,
	d: Vec3,
) -> Vec3 where (T == Capsule || T == Sphere || T == []Vec3) &&
	(V == Capsule || V == Sphere || V == []Vec3) {
	p1 := find_max_in_direction(s1, d)
	p2 := find_max_in_direction(s2, -d)
	return p1 - p2
}

same_direction :: proc(a, b: Vec3) -> bool {
	return l.dot(a, b) > 0
}

crossed_origin :: proc(p, d: Vec3) -> bool {
	return l.dot(p, d) < 0
}

find_max_in_direction :: proc {
	find_max_in_direction_sphere,
	find_max_in_direction_capsule,
	find_max_in_direction_point_slice,
}

find_max_in_direction_capsule :: proc(s: Capsule, d: Vec3) -> Vec3 {
	clamped := l.clamp(
		d,
		s.translation + Vec3{0, s.height / 2, 0},
		s.translation - Vec3{0, s.height / 2, 0},
	)
	return s.translation + (l.normalize(d) * s.radius)
}

find_max_in_direction_sphere :: proc(s: Sphere, d: Vec3) -> Vec3 {
	return s.translation + (l.normalize(d) * s.radius)
}

find_max_in_direction_point_slice :: proc(s: []Vec3, d: Vec3) -> Vec3 {
	max_dot: f32 = -10_000
	max_dot_index: int

	for p, i in s {
		dot := l.dot(p, d)
		if dot > max_dot {
			max_dot = dot
			max_dot_index = i
		}
	}
	return s[max_dot_index]
}
