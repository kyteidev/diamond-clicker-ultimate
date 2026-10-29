extends Label

const TWEEN_DURATION = 0.5
const MOVE_AMOUNT = 40.0


func _ready() -> void:
	global_position.y -= size.y - 20.0

	var tween := create_tween()
	tween.parallel().tween_property(self, "modulate", Color("ffffff00"), TWEEN_DURATION)
	tween.parallel().tween_property(
		self,
		"global_position",
		global_position - Vector2(0.0, MOVE_AMOUNT),
		TWEEN_DURATION,
	)
	tween.finished.connect(queue_free)
