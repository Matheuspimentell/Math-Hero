extends Control

var _sounds: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for sound: AudioStreamPlayer in self.get_children():
		_sounds[sound.name] = sound

func play(sound_name: String) -> void:
	_sounds[sound_name].play()

func stop(sound_name: String) -> void:
	_sounds[sound_name].stop()
