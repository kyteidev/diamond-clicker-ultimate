extends Node

const MAX_HUNGER = 3.0
const STARTING_TARGET = 1000.0

var diamonds: float:
	set(value):
		diamonds = snapped(value, 0.01)
var target_diamonds: float

var cost_mult: float
var hunger_mult: float
var dps: int
var insurance: int

var mult: float:
	set(value):
		mult = value
		highest_mult = max(highest_mult, value)
var pick_mult: float:
	set(value):
		pick_mult = value
		highest_pick_mult = max(highest_pick_mult, value)
var hunger: float:
	set(value):
		hunger = max(value, 0.0)

# STATS
var rounds: int
var active_diamonds: float
var passive_diamonds: float
var diamond_clicked: int
var highest_mult: float
var highest_pick_mult: float
var diamonds_spent: float
var total_bought: int
var most_bought: Dictionary


func reset_values() -> void:
	diamonds = 0.0
	target_diamonds = STARTING_TARGET

	cost_mult = 1.0
	hunger_mult = 1.0
	dps = 0
	insurance = 0

	mult = 1.0
	pick_mult = 1.0
	hunger = MAX_HUNGER

	# STATS
	rounds = 1
	active_diamonds = 0.0
	passive_diamonds = 0.0
	diamond_clicked = 0
	highest_mult = 1.0
	highest_pick_mult = 1.0
	diamonds_spent = 0.0
	total_bought = 0
	most_bought = { "name": "None", "count": 0 }
