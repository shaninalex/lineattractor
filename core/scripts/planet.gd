class_name Planet extends Node2D

@onready var _colorRect: ColorRect = $ColorRect
@onready var _label: Label = $Label
@export var speed: float = 1
@export var planet_mass: float
@export var planet_name: String
@export var planet_color: Color
@export var planet_size: float
@export var move: bool = false

func _ready() -> void:
	_label.text = planet_name
	var mat := _colorRect.material as ShaderMaterial
	mat.set_shader_parameter("circle_color", planet_color)
	# TODO: position colorRect
	#_colorRect.set_size(Vector2(planet_size, planet_size))
	#_colorRect.position = Vector2(planet_size, planet_size)

func _process(delta: float) -> void:
	if move:
		global_position.x += speed * delta
