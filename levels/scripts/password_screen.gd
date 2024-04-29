extends Node2D

var numpad: Dictionary
@onready var question: RichTextLabel = $question
@onready var password: Label = $passwordBox/password
@export var questionFilePath: String
var rng = RandomNumberGenerator.new()
var currentQuestionData: Dictionary

func _ready():
	# Get reference to all numpad keys
	var numpadKeys = self.find_child("numpad").get_children()
	for key in numpadKeys:
		numpad[key.name] = key
	var questionData: Array = get_questions(questionFilePath)
	currentQuestionData = questionData[rng.randi_range(0,questionData.size()-1)]
	question.append_text(set_question_style(currentQuestionData["question"]))

func _input(_event):
	if Input.is_action_pressed("number0"):
		numpad["0"].click()
		password.text += "0"
	elif Input.is_action_pressed("number1"):
		numpad["1"].click()
		password.text += "1"
	elif Input.is_action_pressed("number2"):
		numpad["2"].click()
		password.text += "2"
	elif Input.is_action_pressed("number3"):
		numpad["3"].click()
		password.text += "3"
	elif Input.is_action_pressed("number4"):
		numpad["4"].click()
		password.text += "4"
	elif Input.is_action_pressed("number5"):
		numpad["5"].click()
		password.text += "5"
	elif Input.is_action_pressed("number6"):
		numpad["6"].click()
		password.text += "6"
	elif Input.is_action_pressed("number7"):
		numpad["7"].click()
		password.text += "7"
	elif Input.is_action_pressed("number8"):
		numpad["8"].click()
		password.text += "8"
	elif Input.is_action_pressed("number9"):
		numpad["9"].click()
		password.text += "9"
	elif Input.is_action_pressed("backspace"):
		numpad["backspace"].click()

func set_question_style(text: String):
	return "[center][color=#238531][wave amp=15 freq=2]%s[/wave][/color][/center]" % text

func get_questions(filePath: String):
	if FileAccess.file_exists(filePath):
		var questionFile = FileAccess.open(filePath, FileAccess.READ)
		var questionData = JSON.parse_string(questionFile.get_as_text())
		if questionData is Array:
			return questionData
		else:
			print("Json parsing error...")
	else:
		print("File doesn't exist or isn't available.")
	return null
