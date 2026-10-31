extends TextureRect

const CLICK_COUNTER_SCENE = preload("res://scenes/click_counter.tscn")
const CLICK_PARTICLES_SCENE = preload("res://scenes/click_particles.tscn")

const ROTATION_AMOUNT = 1.4

const BASE_SCALE = 1.0
const HOVER_SCALE = 1.2
const CLICK_SCALE = 1.0

var mouse_hovered := false
var time = 0.0

var sm := StateManager
var om := OptionsManager
var h := Helper


func _physics_process(delta: float) -> void:
	# diamond rotation
	if om.animations:
		time += delta
		rotation_degrees = (cos(deg_to_rad(time * 250))) * 10

	# diamond clicks and mouse hover
	if mouse_hovered:
		if om.animations:
			scale = scale + ((Vector2.ONE * HOVER_SCALE - scale) / 5)

		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and om.animations:
			scale = scale + ((Vector2.ONE * CLICK_SCALE - scale) / 2)

		if Input.is_action_just_pressed("click"):
			sm.diamonds += 1 * sm.pick_mult
			sm.active_diamonds += 1 * sm.pick_mult
			sm.diamond_clicked += 1

			var click_counter: Label = CLICK_COUNTER_SCENE.instantiate()
			click_counter.text = "+%s" % sm.pick_mult
			click_counter.global_position = get_global_mouse_position()
			get_tree().current_scene.add_child(click_counter)

			if om.particles:
				var click_particles: CPUParticles2D = CLICK_PARTICLES_SCENE.instantiate()
				click_particles.global_position = get_global_mouse_position()
				click_particles.amount = round(sm.pick_mult)
				get_tree().current_scene.add_child(click_particles)
				click_particles.restart()
	elif om.animations:
		scale = scale + ((Vector2.ONE * BASE_SCALE - scale) / 2)


func _on_mouse_entered() -> void:
	mouse_hovered = true


func _on_mouse_exited() -> void:
	mouse_hovered = false
