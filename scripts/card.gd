class_name BoosterCard
extends ColorRect

const HOVER_SCALE = 1.1
const BASE_SCALE = 1.0
const CLICK_SCALE = 0.95

var um := UpgradesManager

var data: BoosterCardData

var mouse_hovered := false

var booster_descriptions = {
	um.BoostTypes.MULT: "Multiplier ",
	um.BoostTypes.PICK_MULT: "Pickaxe Multiplier ",
	um.BoostTypes.COST: "Upgrades Cost ",
	um.BoostTypes.DIAMONDS: "Gain ",
	um.BoostTypes.INSURANCE: "Insurance for 1 round",
	um.BoostTypes.HUNGER: "Hunger Duration ",
}

@onready var icon: TextureRect = $TextureRect
@onready var title: Label = $VBoxContainer/Title
@onready var description: Label = $VBoxContainer/Description


func _process(_delta: float) -> void:
	if mouse_hovered:
		scale = scale + ((Vector2.ONE * HOVER_SCALE - scale) / 5)

		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			scale = scale + ((Vector2.ONE * CLICK_SCALE - scale) / 2)

		if Input.is_action_just_pressed("click"):
			pass
	else:
		scale = scale + ((Vector2.ONE * BASE_SCALE - scale) / 2)


func setup(card_data: BoosterCardData) -> void:
	data = card_data
	title.text = data.booster_name

	var atlas := icon.texture.duplicate() as AtlasTexture
	atlas.region = data.icon
	icon.texture = atlas

	var amount_text: String = _match_desc_text(data.type, data.boost_amount)
	var caveat_amount_text: String = _match_desc_text(data.caveat_type, data.caveat_amount)
	description.text = "%s%s" % [booster_descriptions[data.type], amount_text]
	if data.caveat_type:
		description.text += "\n%s%s" % [booster_descriptions[data.caveat_type], caveat_amount_text]


func _match_desc_text(type: int, amount) -> String:
	var amount_text: String
	match type:
		um.BoostTypes.MULT, um.BoostTypes.PICK_MULT, um.BoostTypes.COST, um.BoostTypes.HUNGER:
			var percent = (amount - 1.0) * 100.0
			amount_text = "%+.0f%%" % percent
		um.BoostTypes.DIAMONDS:
			amount_text = "%s minute(s) of DPS" % data.boost_amount
		um.BoostTypes.INSURANCE:
			amount_text = ""
	return amount_text


func _on_mouse_entered() -> void:
	mouse_hovered = true


func _on_mouse_exited() -> void:
	mouse_hovered = false
