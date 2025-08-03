extends CanvasLayer

@export var world: Node2D
@export var source_line: Line2D

@onready var line: Line2D = $GlobalPath


func _ready() -> void:
	line.joint_mode = source_line.joint_mode

func _process(_delta: float) -> void:
	if not world or not source_line:
		return

	var global_points := PackedVector2Array()
	for local_point in source_line.points:
		global_points.append(world.to_global(local_point))
	line.points = global_points
