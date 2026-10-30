extends CanvasLayer

const TWEEN_DURATION = 0.5

var rng := RandomNumberGenerator.new()

var um := UpgradesManager

var bg_orig_alpha: float

@onready var cards_container: HBoxContainer = $CardsContainer
@onready var game: CanvasLayer = get_parent()
@onready var background: ColorRect = $Background


func _ready() -> void:
	visible = false

	bg_orig_alpha = background.color.a


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
		boost_data.caveat_type = boost.caveat

		if boost.caveat != um.BoostTypes.NONE:
			boost_data.caveat_amount = boost.caveat_amount

		card.setup(boost_data)
		card.show_card()

	# set up tween
	background.color.a = 0.0
	var bg_tween := create_tween()
	bg_tween.tween_property(background, "color:a", bg_orig_alpha, TWEEN_DURATION) \
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

	visible = true


func hide_cards_menu() -> void:
	for card in cards_container.get_children():
		card.hide_card()

	# time it takes for clicked booster card to finish tween
	get_tree().create_timer(1.0).timeout.connect(
		func() -> void:
			get_tree().paused = false
			game.reset()

			var bg_tween := create_tween()
			bg_tween.tween_property(background, "color:a", 0.0, TWEEN_DURATION) \
					.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
			bg_tween.finished.connect(
				func() -> void:
					visible = false,
			),
	)
