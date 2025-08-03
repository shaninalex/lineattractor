extends Node2D

@onready var planets: Node2D = $Planets

func _ready() -> void:
	load_planets_from_json("res://resources/plantes.json")
	await get_tree().process_frame
	p_manager.is_ready = true

func load_planets_from_json(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Can't open file: " + path)
		return

	var json_str = file.get_as_text()
	var data = JSON.parse_string(json_str)
	if typeof(data) != TYPE_ARRAY:
		push_error("Invalid planet data format")
		return

	for planet_dict in data:
		var planet_node = preload("res://core/entities/planet.tscn").instantiate()
		planet_node.planet_name = planet_dict["name"]
		planet_node.planet_mass = planet_dict["mass"]
		planet_node.planet_color = Color(planet_dict["color"][0], planet_dict["color"][1], planet_dict["color"][2])
		planet_node.planet_size = planet_dict["size"]
		planet_node.position = Vector2(planet_dict["position"][0], planet_dict["position"][1])
		planet_node.speed = planet_dict["speed"]
		planets.add_child(planet_node)
		p_manager.register_planet(planet_node)
