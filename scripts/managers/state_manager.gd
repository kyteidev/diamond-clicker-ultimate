extends Node

const MAX_HUNGER = 3.0
const STARTING_TARGET = 0.0

var diamonds := 0.0:
	set(value):
		diamonds = snapped(value, 0.01)
var target_diamonds := STARTING_TARGET

var mult := 1.0
var pick_mult := 1.0
var dps: int = 0

var hunger: float = MAX_HUNGER:
	set(value):
		hunger = max(value, 0.0)


func _process(delta: float) -> void:
	diamonds += dps * delta
	hunger -= delta
