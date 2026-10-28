extends TextureRect

const ROTATION_AMOUNT = 1.4

const BASE_SCALE = 1.0
const HOVER_SCALE = 1.2
const CLICK_SCALE = 1.0

var mouse_hovered := false
var time = 0.0


func _physics_process(delta: float) -> void:
	time += delta
	rotation_degrees = (cos(deg_to_rad(time * 250))) * 10

	if mouse_hovered:
		scale = scale + ((Vector2.ONE * HOVER_SCALE - scale) / 5)

		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			scale = scale + ((Vector2.ONE * CLICK_SCALE - scale) / 2)
	else:
		scale = scale + ((Vector2.ONE * BASE_SCALE - scale) / 2)


func _on_mouse_entered() -> void:
	mouse_hovered = true


func _on_mouse_exited() -> void:
	mouse_hovered = false
