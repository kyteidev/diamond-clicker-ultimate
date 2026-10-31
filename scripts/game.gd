extends CanvasLayer

var sm := StateManager
var om := OptionsManager

@onready var cards_menu: CanvasLayer = $CardsMenu
@onready var death_menu: CanvasLayer = $DeathMenu
@onready var particle_rain: CPUParticles2D = $GamePanel/ParticleRain


func _ready() -> void:
	sm.reset_values()


func _process(delta: float) -> void:
	particle_rain.emitting = om.particles

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
	sm.rounds += 1

	sm.target_diamonds = 1000.0 * (2.15 ** (sm.rounds - 1)) * (sm.pick_mult ** 0.25) * (
		sm.mult ** 0.5
	) * sm.hunger_mult
