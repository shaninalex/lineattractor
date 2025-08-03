extends Camera2D

@export var world: Node2D

@export var zoom_min := 0.001
@export var zoom_max := 1_000_000.0
@export var zoom_step := 1.1
@export var lerp_speed := 15.0

var target_position: Vector2
var target_scale: Vector2
var target_zoom: float = 1.0
var dragging := false
var last_mouse_position := Vector2.ZERO

func _ready() -> void:
	if not world: return
	target_scale = Vector2.ONE
	target_position = world.position
	zoom = Vector2.ONE

func _process(delta: float) -> void:
	if not world: return
	world.scale = world.scale.lerp(target_scale, lerp_speed * delta)
	world.position = world.position.lerp(target_position, lerp_speed * delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_camera_zoom_out()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_camera_zoom_in()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			dragging = event.pressed
			last_mouse_position = get_viewport().get_mouse_position()

	elif event is InputEventMouseMotion and dragging:
		var current_mouse_position = get_viewport().get_mouse_position()
		var delta = (current_mouse_position - last_mouse_position)
		target_position += delta
		last_mouse_position = current_mouse_position

func apply_zoom() -> void:
	var mouse_pos := get_viewport().get_mouse_position()
	var world_mouse_before := world.to_local(mouse_pos)
	target_scale = Vector2.ONE * target_zoom
	var world_mouse_after := (mouse_pos - target_position) / target_scale
	var offset := world_mouse_after - world_mouse_before
	target_position += offset * target_scale

func _camera_zoom_in() -> void:
	target_zoom /= zoom_step
	target_zoom = clamp(target_zoom, zoom_min, zoom_max)
	apply_zoom()

func _camera_zoom_out() -> void:
	target_zoom *= zoom_step
	target_zoom = clamp(target_zoom, zoom_min, zoom_max)
	apply_zoom()
