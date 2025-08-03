extends CanvasLayer

@onready var movePlanets: CheckBox = $Node2D/CheckBox

func _ready() -> void:
	movePlanets.connect("pressed", Callable(self, "_on_move_checkbox_pressed"))


func _on_move_checkbox_pressed():
	for p in p_manager.get_all():
		p.move = !p.move
