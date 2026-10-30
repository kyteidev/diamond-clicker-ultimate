extends ProgressBar

var sm := StateManager


func _ready() -> void:
	reset_hunger()


func _process(_delta: float) -> void:
	value = sm.hunger


func reset_hunger() -> void:
	sm.hunger = sm.MAX_HUNGER
	value = sm.MAX_HUNGER
