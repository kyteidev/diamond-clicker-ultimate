class_name ShopItem
extends ColorRect

const BASE_SCALE = 1.0
const HOVER_SCALE = 1.1
const CLICK_SCALE = 1.0

const OVERLAY_TWEEN_DURATION = 0.3

var data: ShopItemData

var mouse_hovered: bool
var tween: Tween
var overlay_tween: Tween

var sm := StateManager

@onready var name_label: Label = $Name
@onready var cost_label: Label = $Cost
@onready var count_label: Label = $Count

@onready var disabled_overlay: ColorRect = $DisabledOverlay


func _ready() -> void:
	mouse_entered.connect(_mouse_entered)
	mouse_exited.connect(_mouse_exited)

	disabled_overlay.visible = false


func _physics_process(_delta: float) -> void:
	cost_label.text = str(data.cost)
	count_label.text = str(data.count)

	if sm.diamonds < data.cost:
		if not disabled_overlay.visible:
			if overlay_tween:
				overlay_tween.kill()
			overlay_tween = create_tween()
			overlay_tween.tween_property(
				disabled_overlay,
				"color",
				Color("0000009b"),
				OVERLAY_TWEEN_DURATION,
			)
		disabled_overlay.visible = true
	else:
		if disabled_overlay.visible:
			if overlay_tween:
				overlay_tween.kill()
			overlay_tween = create_tween()
			overlay_tween.tween_property(
				disabled_overlay,
				"color",
				Color("00000000"),
				OVERLAY_TWEEN_DURATION,
			)
			overlay_tween.finished.connect(
				func() -> void:
					disabled_overlay.visible = false,
			)

	if mouse_hovered and sm.diamonds >= data.cost:
		scale = scale + ((Vector2.ONE * HOVER_SCALE - scale) / 5)

		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			scale = scale + ((Vector2.ONE * CLICK_SCALE - scale) / 2)

		if Input.is_action_just_pressed("click"):
			if sm.diamonds >= data.cost:
				data.count += 1
				sm.diamonds -= data.cost
				sm.dps += data.dps
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
