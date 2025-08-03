extends Camera2D

var zoom_min := Vector2(0.1, 0.1)
var zoom_max := Vector2(1000.0, 1000.0)
var zoom_step := 2.05

var dragging := false
var last_mouse_position := Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	# Zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_camera_zoom_out()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_camera_zoom_in()

		# Start or stop drag
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			dragging = event.pressed
			last_mouse_position = get_viewport().get_mouse_position()

	elif event is InputEventMouseMotion and dragging:
		var current_mouse_position = get_viewport().get_mouse_position()
		var delta = (last_mouse_position - current_mouse_position) * zoom
		position += delta
		last_mouse_position = current_mouse_position

func _camera_zoom_in() -> void:
	var scale_factor := 1.0 - (0.1 * zoom.length()) / 10.0
	scale_factor = clamp(scale_factor, 0.01, 0.95)
	var new_zoom = zoom * scale_factor
	new_zoom.x = clamp(new_zoom.x, zoom_min.x, zoom_max.x)
	new_zoom.y = clamp(new_zoom.y, zoom_min.y, zoom_max.y)
	zoom = new_zoom

func _camera_zoom_out() -> void:
	var scale_factor := 1.0 + (0.1 * zoom.length()) / 10.0
	scale_factor = clamp(scale_factor, 1.05, 5.0)
	var new_zoom = zoom * scale_factor
	new_zoom.x = clamp(new_zoom.x, zoom_min.x, zoom_max.x)
	new_zoom.y = clamp(new_zoom.y, zoom_min.y, zoom_max.y)
	zoom = new_zoom
