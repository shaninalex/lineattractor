extends Line2D

@export var course_length: int = 100
@export var step: int = 10

func _ready() -> void:
	default_color = Color.AQUAMARINE
	width = 1

func _process(delta: float) -> void:
	var start = get_global_mouse_position()
	update_course(start, Vector2.UP)
	
func update_course(start: Vector2, direction: Vector2):
	clear_points()
	for i in course_length:
		var point = start + direction * step * i
		add_point(point)
