extends TextureRect

const CLICK_COUNTER_SCENE = preload("res://scenes/click_counter.tscn")

const ROTATION_AMOUNT = 1.4

const BASE_SCALE = 1.0
const HOVER_SCALE = 1.2
const CLICK_SCALE = 1.0

var mouse_hovered := false
var time = 0.0

var sm := StateManager

@onready var count_label: Label = %DiamondCount


func _physics_process(delta: float) -> void:
	count_label.text = "%s/%s" % [sm.diamonds, "999M"]

	# diamond rotation
	time += delta
	rotation_degrees = (cos(deg_to_rad(time * 250))) * 10

	# diamond clicks and mouse hover
	if mouse_hovered:
		scale = scale + ((Vector2.ONE * HOVER_SCALE - scale) / 5)

		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			scale = scale + ((Vector2.ONE * CLICK_SCALE - scale) / 2)

		if Input.is_action_just_pressed("click"):
			sm.diamonds += 1 * sm.pick_mult

			var click_counter: Label = CLICK_COUNTER_SCENE.instantiate()
			click_counter.text = "+%s" % sm.pick_mult
			click_counter.global_position = get_global_mouse_position()
			get_tree().current_scene.add_child(click_counter)
	else:
		scale = scale + ((Vector2.ONE * BASE_SCALE - scale) / 2)


func _on_mouse_entered() -> void:
	mouse_hovered = true


func _on_mouse_exited() -> void:
	mouse_hovered = false
