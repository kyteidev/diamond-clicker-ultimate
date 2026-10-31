extends CanvasLayer

const TWEEN_DURATION = 0.5

var bg_orig_alpha: float
var stats_orig_pos: Vector2
var title_orig_pos: Vector2

var sm := StateManager
var h := Helper

@onready var background: ColorRect = $Background
@onready var stats: ColorRect = $Stats
@onready var title: Label = $Label

@onready var stats_container: VBoxContainer = $Stats/StatsContainer


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

	# update stats
	var index = 0
	for child in stats_container.get_children():
		var count: Label = child.get_child(1) # label node
		var text: String
		match index:
			0:
				text = str(sm.rounds)
			1:
				text = h.shorten_number(floori(sm.active_diamonds + sm.passive_diamonds))
			2:
				text = h.shorten_number(floori(sm.active_diamonds))
			3:
				text = h.shorten_number(floori(sm.passive_diamonds))
			4:
				text = str(sm.diamond_clicked)
			5:
				text = "%sx" % sm.highest_mult
			6:
				text = "%sx" % sm.highest_pick_mult
			7:
				text = h.shorten_number(floori(sm.diamonds_spent))
			8:
				text = str(sm.total_bought)
			9:
				text = "%s [%s]" % [sm.most_bought["name"], sm.most_bought["count"]]
		count.text = text
		index += 1

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
