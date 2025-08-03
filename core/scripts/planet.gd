class_name Planet extends Node2D

@onready var _label: Label = $Label

@export var speed: float = 1
@export var planet_mass: float
@export var planet_name: String
@export var planet_color: Color
@export var planet_size: float
@export var move: bool = false

func _ready() -> void:
	update_visuals()

func _process(delta: float) -> void:
	if move:
		position.x += speed * delta

func _draw() -> void:
	# planet circle
	var radius = planet_size * 0.5
	draw_circle(Vector2.ZERO, radius, planet_color)

func update_visuals() -> void:
	var half_size: float = planet_size * 0.5
	var center: Vector2 = Vector2(-half_size, -half_size)

	# label
	_label.text = planet_name
	await get_tree().process_frame  # Wait 1 frame for label size to update
	var label_size = _label.get_minimum_size()
	_label.position = Vector2(-label_size.x / 2.0, -label_size.y / 2.0)
