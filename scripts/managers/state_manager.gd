extends Node

const MAX_HUNGER = 180.0
const STARTING_TARGET = 1000.0

var diamonds := 0.0:
	set(value):
		diamonds = snapped(value, 0.01)
var target_diamonds := STARTING_TARGET

var cost_mult := 1.0
var hunger_mult := 1.0
var dps: int = 0
var insurance: int = 0

var mult := 1.0:
	set(value):
		mult = value
		highest_mult = max(highest_mult, value)
var pick_mult := 1.0:
	set(value):
		pick_mult = value
		highest_pick_mult = max(highest_pick_mult, value)
var hunger: float = MAX_HUNGER:
	set(value):
		hunger = max(value, 0.0)

# STATS
var rounds: int = 1
var active_diamonds := 0.0
var passive_diamonds := 0.0
var diamond_clicked: int = 0
var highest_mult := 1.0
var highest_pick_mult := 1.0
var diamonds_spent := 0.0
var total_bought: int = 0
var most_bought := { "name": "None", "count": 0 }
