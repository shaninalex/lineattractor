extends Camera2D

var zoom_min := Vector2(0.1, 0.1)
var zoom_max := Vector2(1000.0, 1000.0)
var zoom_step := 1.05

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_camera_zoom_out()
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_camera_zoom_in()

func _camera_zoom_in() -> void:
	var new_zoom = zoom / zoom_step
	new_zoom.x = clamp(new_zoom.x, zoom_min.x, zoom_max.x)
	new_zoom.y = clamp(new_zoom.y, zoom_min.y, zoom_max.y)
	zoom = new_zoom

func _camera_zoom_out() -> void:
	var new_zoom = zoom * zoom_step
	zoom = new_zoom
