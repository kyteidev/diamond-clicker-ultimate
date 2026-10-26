class_name ShopItem
extends ColorRect

const HOVER_SCALE = 1.1
const HOVER_TWEEN_DURATION = 0.1

var data: ShopItemData

var mouse_hovered: bool

@onready var name_label: Label = $Name
@onready var cost_label: Label = $Cost
@onready var count_label: Label = $Count


func _ready() -> void:
	mouse_entered.connect(_mouse_entered)
	mouse_exited.connect(_mouse_exited)


func setup(item_data: ShopItemData) -> void:
	data = item_data

	name_label.text = data.name
	cost_label.text = str(data.cost)
	count_label.text = str(data.count)


func _mouse_entered() -> void:
	mouse_hovered = true

	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * HOVER_SCALE, HOVER_TWEEN_DURATION) \
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func _mouse_exited() -> void:
	mouse_hovered = false

	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, HOVER_TWEEN_DURATION) \
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
