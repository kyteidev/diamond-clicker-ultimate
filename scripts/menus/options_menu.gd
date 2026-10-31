extends CanvasLayer

var om := OptionsManager
@onready var particle_rain: CPUParticles2D = $ParticleRain

@onready var particles_button: CheckButton = $OptionsMainContainer/OptionsPanel1/Option1/CheckButton
@onready var crt_button: CheckButton = $OptionsMainContainer/OptionsPanel1/Option2/CheckButton
@onready var anim_button: CheckButton = $OptionsMainContainer/OptionsPanel1/Option3/CheckButton
@onready var bgm_button: CheckButton = $OptionsMainContainer/OptionsPanel1/Option4/CheckButton
@onready var sfx_button: CheckButton = $OptionsMainContainer/OptionsPanel1/Option5/CheckButton
@onready var vsync_button: CheckButton = $OptionsMainContainer/OptionsPanel2/Option1/CheckButton


func _ready() -> void:
	particle_rain.emitting = om.particles

	particles_button.button_pressed = om.particles
	crt_button.button_pressed = om.crt_shader
	anim_button.button_pressed = om.animations
	bgm_button.button_pressed = om.bgm
	sfx_button.button_pressed = om.sfx
	vsync_button.button_pressed = om.vsync


func _on_back_button_pressed() -> void:
	SFX.play("click")
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


# yes i know this is really bad code, i'm too lazy to implement this better
# since there are so few settings available
func _on_particles_button_toggled(toggled_on: bool) -> void:
	SFX.play("click")
	om.particles = toggled_on

	particle_rain.emitting = om.particles


func _on_crt_button_toggled(toggled_on: bool) -> void:
	SFX.play("click")
	om.crt_shader = toggled_on


func _on_animations_button_toggled(toggled_on: bool) -> void:
	SFX.play("click")
	om.animations = toggled_on


func _on_bgm_button_toggled(toggled_on: bool) -> void:
	SFX.play("click")
	om.bgm = toggled_on

	SFX.bgm_player.volume_db = -5.0 if toggled_on else -99.0


func _on_sfx_button_toggled(toggled_on: bool) -> void:
	SFX.play("click")
	om.sfx = toggled_on


func _on_vsync_button_toggled(toggled_on: bool) -> void:
	SFX.play("click")
	om.vsync = toggled_on

	DisplayServer.window_set_vsync_mode(
		DisplayServer.VSYNC_ENABLED if toggled_on else DisplayServer.VSYNC_DISABLED
	)
