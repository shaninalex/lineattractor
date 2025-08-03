class_name PlanetManager extends Node

var is_ready: bool = false
var planets: Array[Node2D] = []

func register_planet(planet: Node2D) -> void:
	print("Registered: ", planet, " Name: ", planet.planet_name)
	print("Type: ", planet.get_class(), " Is Planet? ", planet is Planet)
	planets.append(planet)

func get_all() -> Array[Node2D]:
	return planets
