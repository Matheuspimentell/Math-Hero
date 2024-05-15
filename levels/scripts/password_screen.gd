extends Node2D

var numpad: Dictionary
@onready var question: RichTextLabel = $question
@onready var password: Label = $passwordBox/password
var sumGenerator = SumGenerator.new(null)
var operations: Array
var currentOp: int

func _ready():
	# Get reference to all numpad keys
	var numpadKeys = self.find_child("numpad").get_children()
	for key in numpadKeys:
		numpad[key.name] = key
	operations = sumGenerator.gen_one_digit_restricted(10)
	print(operations)
	currentOp = 0
	self._change_question_text('%s + %s = ?' % [operations[currentOp].a, operations[currentOp].b])

func _input(_event):
	if Input.is_action_just_pressed("number0"):
		numpad["0"].click()
		password.text += "0"
	elif Input.is_action_just_pressed("number1"):
		numpad["1"].click()
		password.text += "1"
	elif Input.is_action_just_pressed("number2"):
		numpad["2"].click()
		password.text += "2"
	elif Input.is_action_just_pressed("number3"):
		numpad["3"].click()
		password.text += "3"
	elif Input.is_action_just_pressed("number4"):
		numpad["4"].click()
		password.text += "4"
	elif Input.is_action_just_pressed("number5"):
		numpad["5"].click()
		password.text += "5"
	elif Input.is_action_just_pressed("number6"):
		numpad["6"].click()
		password.text += "6"
	elif Input.is_action_just_pressed("number7"):
		numpad["7"].click()
		password.text += "7"
	elif Input.is_action_just_pressed("number8"):
		numpad["8"].click()
		password.text += "8"
	elif Input.is_action_just_pressed("number9"):
		numpad["9"].click()
		password.text += "9"
	elif Input.is_action_just_pressed("backspace"):
		numpad["backspace"].click()
	elif Input.is_action_just_pressed("accept"):
		if str(operations[currentOp].res) == password.text:
			print('correct answer')
			if(currentOp == operations.size()-1):
				print('Congrats!')
			else:
				currentOp+=1
				self._change_question_text('%s + %s = ?' % [operations[currentOp].a, operations[currentOp].b])
				password.text = ''
		else:
			print('wrong answer')
			password.text = ''

func _set_question_style(text: String):
	return "[center][color=#238531][wave amp=15 freq=2]%s[/wave][/color][/center]" % text

func _change_question_text(newText: String):
	question.clear()
	question.append_text(self._set_question_style(newText))
