extends CanvasLayer

var sm := StateManager

@onready var cards_menu: CanvasLayer = $CardsMenu
@onready var death_menu: CanvasLayer = $DeathMenu


func _ready() -> void:
	reset()


func _process(_delta: float) -> void:
	if sm.hunger == 0:
		if sm.diamonds >= sm.target_diamonds:
			cards_menu.show_cards_menu()
		else:
			death_menu.show_death_menu()


func reset() -> void:
	sm.hunger = sm.MAX_HUNGER
