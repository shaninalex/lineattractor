class_name PathManager extends Node

func simulate_path(start_pos: Vector2, start_velocity: Vector2, bodies: Array[Planet], steps := 500, dt := 0.1) -> PackedVector2Array:
	var path := PackedVector2Array()
	var pos := start_pos
	var vel := start_velocity
	
	for i in steps:
		var acc := Vector2.ZERO
		for body in bodies:
			var r : Vector2 = body.global_position - pos
			var distance_sq := r.length_squared()
			if distance_sq < 1.0:
				continue # avoid division by zero
			acc += body.planet_mass * r.normalized() / distance_sq
		
		vel += acc * dt
		pos += vel * dt
		path.append(pos)
	
	return path
