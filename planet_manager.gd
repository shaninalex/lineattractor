class_name PlanetManager extends Node

var planets: Array[Node2D] = []

func register_planet(planet: Node2D) -> void:
	planets.append(planet)

func get_all() -> Array[Node2D]:
	return planets
