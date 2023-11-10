extends CanvasLayer

var currentQuestion = {"operation": "x + y = ?", "result": null}
# Called when the node enters the scene tree for the first time.
func _ready():
	currentQuestion = load_random_operation()
	$Operation.text = "[center] %s [/center]" % currentQuestion.operation

func load_random_operation():
	var file = FileAccess.open("res://models/operations/sum/sums.json", FileAccess.READ)

	var rng = RandomNumberGenerator.new()
	
	var json = JSON.new()
	json.parse(file.get_as_text())
	var data = json.get_data()
	
	return data[rng.randi_range(0, len(data) - 1)]

func _on_submit(text:String):
	var resultInt = int(currentQuestion.result)
	if text == str(resultInt):
		print("Right answer!")
	else:
		print("wrong_answer")

