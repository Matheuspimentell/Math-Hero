extends Node

var _sounds: Dictionary

func _ready():
	for sound: AudioStreamPlayer in get_children():
		_sounds[sound.name] = sound
	
func play_sound(soundName: String):
	if not _sounds.has(soundName):
		print_debug("Sound name not found in sfx manager.")
		return

	_sounds[soundName].play()