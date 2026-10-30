extends CanvasLayer

var rng := RandomNumberGenerator.new()

var um := UpgradesManager

@onready var cards_container: HBoxContainer = $CardsContainer


func _ready() -> void:
	visible = false


func show_cards_menu() -> void:
	get_tree().paused = true

	# randomly pick booster cards and show them
	for card in cards_container.get_children():
		var boost: Dictionary
		var random: float = rng.randf()
		if random <= um.RARITY_CHANCES[um.BoostRarities.LEGENDARY]:
			boost = um.LEGENDARY_BOOSTS.pick_random()
		elif random <= um.RARITY_CHANCES[um.BoostRarities.RARE]:
			boost = um.RARE_BOOSTS.pick_random()
		else:
			boost = um.COMMON_BOOSTS.pick_random()

		var boost_data := BoosterCardData.new()
		boost_data.booster_name = boost.name
		boost_data.icon = boost.icon
		boost_data.type = boost.type
		boost_data.boost_amount = boost.amount

		if boost.caveat:
			boost_data.caveat_type = boost.caveat
			boost_data.caveat_amount = boost.caveat_amount

		card.setup(boost_data)
	visible = true
