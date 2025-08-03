extends Node2D

@onready var stars := $StarParticles

@export var parallax_strength := 0.05
@export var lerp_speed := 5.0

var dragging := false
var last_mouse_position := Vector2.ZERO
var target_position := Vector2.ZERO

func _ready() -> void:
	target_position = stars.global_position

func _process(delta: float) -> void:
	stars.global_position = stars.global_position.lerp(target_position, lerp_speed * delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			dragging = event.pressed
			last_mouse_position = get_viewport().get_mouse_position()

	elif event is InputEventMouseMotion and dragging:
		var current_mouse_position = get_viewport().get_mouse_position()
		var delta = current_mouse_position - last_mouse_position
		last_mouse_position = current_mouse_position

		target_position += delta * parallax_strength
