extends Node

var diamonds := 0.0:
	set(value):
		diamonds = snapped(value, 0.01)

var mult := 1.0
var pick_mult := 1.0
var dps: int = 0


func _process(delta: float) -> void:
	diamonds += dps * delta
