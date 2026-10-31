class_name ShopItem
extends ColorRect

const BASE_SCALE = 1.0
const HOVER_SCALE = 1.1
const CLICK_SCALE = 1.0

const OVERLAY_TWEEN_DURATION = 0.15

var data: ShopItemData

var mouse_hovered: bool
var tween: Tween
var overlay_tween: Tween

var sm := StateManager
var um := UpgradesManager
var om := OptionsManager
var h := Helper

var cost: float:
	set(value):
		cost = value
		data.cost = value
	get():
		return cost * sm.cost_mult

@onready var name_label: Label = $Name
@onready var count_label: Label = $Count

@onready var cost_label: Label = $Container/Cost
@onready var dps_label: Label = $Container/DPS

@onready var disabled_overlay: ColorRect = $DisabledOverlay


func _ready() -> void:
	mouse_entered.connect(_mouse_entered)
	mouse_exited.connect(_mouse_exited)

	disabled_overlay.visible = false


func _physics_process(_delta: float) -> void:
	cost_label.text = h.shorten_number(cost)
	count_label.text = h.shorten_number(data.count)
	dps_label.text = "+%s" % h.shorten_number(data.dps * sm.mult)

	if sm.diamonds < cost:
		if not disabled_overlay.visible:
			if overlay_tween:
				overlay_tween.kill()
			overlay_tween = create_tween()
			overlay_tween.tween_property(
				disabled_overlay,
				"color",
				Color("0000009b"),
				OVERLAY_TWEEN_DURATION if om.animations else 0.0,
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
				OVERLAY_TWEEN_DURATION if om.animations else 0.0,
			)
			overlay_tween.finished.connect(
				func() -> void:
					disabled_overlay.visible = false,
			)

	if mouse_hovered and sm.diamonds >= cost:
		if om.animations:
			scale = scale + ((Vector2.ONE * HOVER_SCALE - scale) / 5)

		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and om.animations:
			scale = scale + ((Vector2.ONE * CLICK_SCALE - scale) / 2)

		if Input.is_action_just_pressed("click"):
			if sm.diamonds >= cost:
				data.count += 1
				sm.diamonds -= cost
				sm.dps += data.dps

				cost *= um.COST_MULT
				cost = snapped(cost, 0.01)

				# for stats
				if data.count > sm.most_bought["count"]:
					sm.most_bought["name"] = data.name
					sm.most_bought["count"] = data.count
				sm.diamonds_spent += cost
				sm.total_bought += 1

				SFX.play("click", 6.0)
	elif om.animations:
		scale = scale + ((Vector2.ONE * BASE_SCALE - scale) / 2)


func setup(item_data: ShopItemData) -> void:
	data = item_data
	cost = data.cost

	name_label.text = data.name
	cost_label.text = str(cost)
	count_label.text = str(data.count)
	dps_label.text = "+%s" % str(data.dps)


func _mouse_entered() -> void:
	mouse_hovered = true


func _mouse_exited() -> void:
	mouse_hovered = false
