extends CanvasLayer
signal hasFinishedDialogues

@export_file("*.json") var filePath: String

var currentDialogue
var dialogues = []
var active = false

# At start, make dialogue invisible
func _ready():
	$NinePatchRect.visible = active

# Load the dialogues from the json file
func load_dialogues():
	var file = FileAccess.open(filePath, FileAccess.READ)
	
	var json = JSON.new()
	json.parse(file.get_as_text())
	
	return json.get_data()

# If the "Enter" key is pressed, then skip to the next dialogue text
func _input(event):
	if not active:
		return

	if event.is_action_pressed("accept"):
		next_dialogue()
	return

# Pass to the next dialogue in the list
func next_dialogue():
	currentDialogue += 1

	if currentDialogue >= len(dialogues):
		active = false
		$NinePatchRect.visible = active
		hasFinishedDialogues.emit()
		return
	
	$NinePatchRect/CharacterName.text = dialogues[currentDialogue]['name']
	$NinePatchRect/Message.text = dialogues[currentDialogue]['text']

	return

# Start the dialogues and make them visible
func start_dialogue():
	if active:
		return
	
	active = true
	$NinePatchRect.visible = active
	dialogues = load_dialogues()
	currentDialogue = -1
	next_dialogue()
	
	return
