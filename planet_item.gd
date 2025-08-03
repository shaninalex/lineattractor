extends Node2D


@onready var planet: Planet = Planet.new()
@onready var _colorRect: ColorRect = $ColorRect
@onready var _label: Label = $Label

@export var speed: float = 10
@export var planet_mass: float
@export var planet_name: String
@export var planet_color: Color
@export var planet_size: float
@export var move: bool = true

func _ready() -> void:
	planet.planet_mass = planet_mass
	planet.planet_name = planet_name
	planet.planet_color = planet_color
	planet.planet_size = planet_size
	
	_label.text = planet_name
	# draw planet
	#_colorRect.hide()
	var mat := _colorRect.material as ShaderMaterial
	mat.set_shader_parameter("circle_color", planet_color)
	# TODO: position colorRect
	#_colorRect.set_size(Vector2(planet_size, planet_size))
	#_colorRect.position = Vector2(planet_size, planet_size)
	
	# register planet
	p_manager.register_planet(self)

func _process(delta: float) -> void:
	if move:
		global_position.x += speed * delta
