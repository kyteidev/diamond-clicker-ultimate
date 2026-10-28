class_name ShopItem
extends ColorRect

const BASE_SCALE = 1.0
const HOVER_SCALE = 1.1
const CLICK_SCALE = 1.0

var data: ShopItemData

var mouse_hovered: bool
var tween: Tween

@onready var name_label: Label = $Name
@onready var cost_label: Label = $Cost
@onready var count_label: Label = $Count


func _ready() -> void:
	mouse_entered.connect(_mouse_entered)
	mouse_exited.connect(_mouse_exited)


func _physics_process(_delta: float) -> void:
	if mouse_hovered:
		scale = scale + ((Vector2.ONE * HOVER_SCALE - scale) / 5)

		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			scale = scale + ((Vector2.ONE * CLICK_SCALE - scale) / 2)
	else:
		scale = scale + ((Vector2.ONE * BASE_SCALE - scale) / 2)


func setup(item_data: ShopItemData) -> void:
	data = item_data

	name_label.text = data.name
	cost_label.text = str(data.cost)
	count_label.text = str(data.count)


func _mouse_entered() -> void:
	mouse_hovered = true


func _mouse_exited() -> void:
	mouse_hovered = false
