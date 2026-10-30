extends CanvasLayer

var sm := StateManager


func _ready() -> void:
	reset()


func _process(_delta: float) -> void:
	if sm.hunger == 0:
		if sm.diamonds >= sm.target_diamonds:
			pass
		else:
			pass


func reset() -> void:
	sm.hunger = sm.MAX_HUNGER
