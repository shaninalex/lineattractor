extends CanvasLayer

@onready var movePlanets: CheckBox = $MovePlanetsCheckBox

func _ready() -> void:
	movePlanets.connect("pressed", Callable(self, "_on_move_checkbox_pressed"))


func _on_move_checkbox_pressed():
	for p in p_manager.get_all():
		p.move = !p.move
