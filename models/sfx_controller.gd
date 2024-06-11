extends Node

var soundBoard: Dictionary

func _ready():
	var sounds = self.get_children()
	for sound in sounds:
		soundBoard[sound.name] = sound

func _on_numpad_clicked(key:String):
	if key == 'backspace':
		#TODO send erase singal to passwordbox
		pass
	else:
		soundBoard['click'].play()
		#TODO send append signal to passwordBox