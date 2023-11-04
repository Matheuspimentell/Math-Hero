extends CanvasLayer

func _ready():
	var dialogues = load_dialogues()
	print(dialogues[0]['name'])

func load_dialogues():
	var file = FileAccess.open("res://models/npcs/hostile/dialogues.json", FileAccess.READ)
	
	var json = JSON.new()
	json.parse(file.get_as_text())
	return json.get_data()
