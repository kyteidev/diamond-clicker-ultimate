extends Label

var sm := StateManager


func _process(_delta: float) -> void:
	text = "DPS: %s" % sm.dps
