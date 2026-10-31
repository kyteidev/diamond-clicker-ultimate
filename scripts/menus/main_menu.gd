extends CanvasLayer

const TITLE_BOB_AMOUNT = 8.0
const TITLE_BOB_DURATION = 0.8

var om := OptionsManager

var time := 0.0

@onready var title: Label = $Title
@onready var diamond: TextureRect = $Diamond
@onready var particle_rain: CPUParticles2D = $ParticleRain


func _ready() -> void:
	if om.animations:
		var title_orig_y = title.global_position.y
		var title_tween := create_tween().set_loops()
		title_tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		title_tween.tween_property(
			title,
			"global_position:y",
			title_orig_y + TITLE_BOB_AMOUNT,
			TITLE_BOB_DURATION,
		)
		title_tween.tween_property(
			title,
			"global_position:y",
			title_orig_y - TITLE_BOB_AMOUNT,
			TITLE_BOB_DURATION,
		)


func _process(delta: float) -> void:
	if om.animations:
		time += delta
		diamond.rotation_degrees = (cos(deg_to_rad(time * 150))) * 10

	particle_rain.emitting = om.particles


func _on_play_button_pressed() -> void:
	SFX.play("click")
	TransitionManager.transition_switch("res://scenes/game.tscn")


func _on_options_button_pressed() -> void:
	SFX.play("click")
	get_tree().change_scene_to_file("res://scenes/menus/options_menu.tscn")


func _on_quit_button_pressed() -> void:
	SFX.play("click")
	get_tree().quit()
