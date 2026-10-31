extends Node

var sounds: Dictionary = {
	"card": preload("res://assets/sfx/card.wav"),
	"card_slide": preload("res://assets/sfx/card_slide.wav"),
	"click": preload("res://assets/sfx/click.wav"),
	"defeat": preload("res://assets/sfx/defeat.wav"),
	"mine": preload("res://assets/sfx/mine.wav"),
	"stat": preload("res://assets/sfx/stat.wav"),
}

var bgm_player := AudioStreamPlayer.new()
var bgm: Resource = preload("res://assets/bgm/Patreon Challenge 03.ogg")

var om := OptionsManager


func _ready() -> void:
	# loop background music
	bgm_player.stream = bgm
	bgm_player.volume_db = -5.0
	add_child(bgm_player)
	bgm_player.play()


func play(sound_name: String, volume := 0.0, pitch := 0.1) -> void:
	if not om.sfx:
		return

	var player := AudioStreamPlayer.new()
	player.stream = sounds[sound_name]
	player.volume_db = volume
	player.pitch_scale = randf_range(1.0 - pitch, 1.0 + pitch)

	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)
