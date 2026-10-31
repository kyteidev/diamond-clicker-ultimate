extends Label

var sm := StateManager
var h := Helper


func _process(_delta: float) -> void:
	text = "DPS: %s" % h.shorten_number(floori(sm.dps * sm.mult))
