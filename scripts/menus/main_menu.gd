extends CanvasLayer

const TITLE_BOB_AMOUNT = 8.0
const TITLE_BOB_DURATION = 0.8

var time := 0.0

@onready var title: Label = $Title
@onready var diamond: TextureRect = $Diamond


func _ready() -> void:
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
	time += delta
	diamond.rotation_degrees = (cos(deg_to_rad(time * 150))) * 10


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
