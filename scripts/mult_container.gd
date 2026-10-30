extends VBoxContainer

var sm := StateManager
var h := Helper

@onready var mult_label: Label = $MultLabel
@onready var pick_mult_label: Label = $PickMultLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	mult_label.text = "Mult: %sx" % h.shorten_number(sm.mult)
	pick_mult_label.text = "Pickaxe Mult: %sx" % h.shorten_number(sm.pick_mult)
