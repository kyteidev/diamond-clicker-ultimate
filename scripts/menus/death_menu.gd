extends CanvasLayer

const TWEEN_DURATION = 0.5

var bg_orig_alpha: float
var stats_orig_pos: Vector2
var title_orig_pos: Vector2

@onready var background: ColorRect = $Background
@onready var stats: ColorRect = $ColorRect
@onready var title: Label = $Label


func _ready() -> void:
	visible = false

	bg_orig_alpha = background.color.a
	stats_orig_pos = stats.global_position
	title_orig_pos = title.global_position


func show_death_menu() -> void:
	get_tree().paused = true

	background.color.a = 0.0

	stats.global_position.x = 1920 + stats.size.x
	title.global_position.x = -title.size.x

	visible = true

	var bg_tween := create_tween()
	bg_tween.tween_property(background, "color:a", bg_orig_alpha, TWEEN_DURATION) \
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

	var stats_tween := create_tween()
	stats_tween.tween_property(stats, "global_position:x", stats_orig_pos.x, TWEEN_DURATION) \
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).set_delay(TWEEN_DURATION)

	var title_tween := create_tween()
	title_tween.tween_property(title, "global_position:x", title_orig_pos.x, TWEEN_DURATION) \
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).set_delay(TWEEN_DURATION)
