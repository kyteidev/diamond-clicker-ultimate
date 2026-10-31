extends Node

const Y = -950.0
const LEFT_X = -5672.0
const CENTER_X = -2000
const RIGHT_X = 1572

const TWEEN_DURATION = 0.5

@onready var rect_scene: PackedScene = preload("res://scenes/transition.tscn")


func transition_switch(scene_path: String) -> void:
	var root = rect_scene.instantiate()
	get_tree().root.add_child(root)

	var rect = root.get_child(0)
	rect.position = Vector2(LEFT_X, Y)

	var tween_in := create_tween()
	tween_in.tween_property(rect, "position:x", CENTER_X, TWEEN_DURATION) \
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween_in.finished.connect(
		func() -> void:
			get_tree().change_scene_to_file(scene_path)
			await get_tree().process_frame

			var tween_out := create_tween()
			tween_out.tween_property(rect, "position:x", RIGHT_X, TWEEN_DURATION) \
					.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
			tween_out.finished.connect(root.queue_free),
	)
