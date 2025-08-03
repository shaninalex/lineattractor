extends Line2D

@export var course_length: int = 10000
@export var step: float = 0.05
@export var G: float = 10000.0
@export var initial_velocity: Vector2 = Vector2(0, -150)

func _ready() -> void:
	default_color = Color.GREEN
	width = 1
	antialiased = true

func _process(_delta: float) -> void:
	if p_manager.get_all().is_empty():
		return

	var start = get_global_mouse_position()
	var planets = p_manager.get_all()
	var _points = simulate_path(start, initial_velocity, planets, course_length, step)
	draw_course(_points)

func draw_course(_points: PackedVector2Array) -> void:
	clear_points()
	for point in _points:
		add_point(point)

func simulate_path(start_pos: Vector2, start_velocity: Vector2, bodies: Array, steps: int, dt: float) -> PackedVector2Array:
	var path := PackedVector2Array()
	var pos := start_pos
	var vel := start_velocity

	for i in steps:
		var acc := Vector2.ZERO
		for body in bodies:
			if not body.is_inside_tree():
				continue
			var r : Vector2 = body.global_position - pos
			var distance_sq := r.length_squared()
			if distance_sq < 1.0:
				continue
				
			var scaled_mass = body.planet_mass / 1e22
			acc += G * scaled_mass * r.normalized() / distance_sq
		
		vel += acc * dt
		var new_pos := pos + vel * dt
		for body in bodies:
			var planet_radius = body.planet_size / 2.0
			if path_manager.segment_intersects_circle(pos, new_pos, body.global_position, planet_radius):
				# TODO: signal about hit the planet
				#print("Hit planet ", body.planet_name, " at ", new_pos)
				path.append(new_pos)
				return path

		pos = new_pos
		path.append(pos)
	
	return path
