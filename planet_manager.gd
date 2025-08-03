class_name PlanetManager extends Node

var planets: Array[Planet] = []

func register_planet(planet: Planet) -> void:
	planets.append(planet)

func get_all() -> Array[Planet]:
	return planets
