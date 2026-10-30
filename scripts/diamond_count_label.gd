extends Label

var sm := StateManager
var h := Helper


func _process(_delta: float) -> void:
	text = "%s/%s" % [
		h.shorten_number(floori(sm.diamonds)),
		h.shorten_number(floori(sm.target_diamonds)),
	]
