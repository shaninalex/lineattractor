extends Node2D

@onready var planet: Planet = Planet.new()
@onready var _colorRect: ColorRect = $ColorRect

@export var planet_mass: float
@export var planet_name: String
@export var planet_color: Color
@export var planet_size: float

func _ready() -> void:
	planet.planet_mass = planet_mass
	planet.planet_name = planet_name
	planet.planet_color = planet_color
	planet.planet_size = planet_size
	
	# draw planet
	var mat := _colorRect.material as ShaderMaterial
	mat.set_shader_parameter("circle_color", planet_color)
	_colorRect.set_size(Vector2(planet_size, planet_size))
	
	# register planet
	p_manager.register_planet(planet)
	
