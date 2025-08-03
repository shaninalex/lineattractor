class_name PathManager extends Node

func simulate_path(start_pos: Vector2, start_velocity: Vector2, bodies: Array[Planet], steps := 500, dt := 0.1) -> PackedVector2Array:
	var path := PackedVector2Array()
	var pos := start_pos
	var vel := start_velocity
	
	for i in steps:
		var acc := Vector2.ZERO

		for body in bodies:
			var r: Vector2 = body.global_position - pos
			var distance_sq := r.length_squared()
			if distance_sq < 1.0:
				continue

			var gravity_acc := body.planet_mass * r.normalized() / distance_sq
			acc += gravity_acc
		
		vel += acc * dt
		pos += vel * dt
		path.append(pos)
	
	return path

func segment_intersects_circle(p1: Vector2, p2: Vector2, center: Vector2, radius: float) -> bool:
	var d := p2 - p1
	var f := p1 - center

	var a := d.dot(d)
	var b := 2 * f.dot(d)
	var c := f.dot(f) - radius * radius

	var discriminant := b * b - 4 * a * c
	if discriminant < 0:
		return false

	discriminant = sqrt(discriminant)
	var t1 := (-b - discriminant) / (2 * a)
	var t2 := (-b + discriminant) / (2 * a)

	return (t1 >= 0.0 and t1 <= 1.0) or (t2 >= 0.0 and t2 <= 1.0)
