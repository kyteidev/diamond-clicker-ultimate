extends CanvasLayer

var sm := StateManager

@onready var cards_menu: CanvasLayer = $CardsMenu
@onready var death_menu: CanvasLayer = $DeathMenu


func _ready() -> void:
	sm.hunger = sm.MAX_HUNGER * sm.hunger_mult


func _process(delta: float) -> void:
	sm.diamonds += sm.dps * delta
	sm.passive_diamonds += sm.dps * delta
	sm.hunger -= delta

	if sm.hunger == 0:
		if sm.diamonds >= sm.target_diamonds or sm.insurance > 0:
			cards_menu.show_cards_menu()
		else:
			death_menu.show_death_menu()

			sm.insurance = max(sm.insurance - 1, 0)


func new_round() -> void:
	sm.hunger = sm.MAX_HUNGER * sm.hunger_mult
	sm.target_diamonds *= 1.5
	sm.rounds += 1
