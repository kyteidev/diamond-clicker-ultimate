extends ProgressBar

var sm := StateManager


func _process(_delta: float) -> void:
	value = sm.hunger
