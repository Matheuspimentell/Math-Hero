extends Node2D

var numpad: Dictionary
var sfxs: Dictionary
@onready var question: RichTextLabel = $question
@onready var password: Label = $password_box/password
@onready var sfx_controller: Node = $sfx_controller
var sumGenerator = SumGenerator.new(null)
var operations: Array
var _currentOp: int = 0

# Levels: One digit restricted, One digit unrestricted, Two digit restricted, Two digit unrestricted, Three digit restricted, Three digit unrestricted
var _currentLevel: int = 0

func _ready():
	# Get reference to all numpad keys
	var numpadKeys = self.find_child("numpad").get_children()
	for key in numpadKeys:
		numpad[key.name] = key

	operations = sumGenerator.gen_one_digit_restricted(2)
	print(operations)
	self._change_question_text('%s + %s = ?' % [operations[_currentOp].a, operations[_currentOp].b])

	var sound_effects = sfx_controller.get_children()
	for effect in sound_effects:
		sfxs[effect.name] = effect

func _input(_event):
	if Input.is_action_just_pressed("number0"):
		numpad["0"].click()
	elif Input.is_action_just_pressed("number1"):
		numpad["1"].click()
	elif Input.is_action_just_pressed("number2"):
		numpad["2"].click()
	elif Input.is_action_just_pressed("number3"):
		numpad["3"].click()
	elif Input.is_action_just_pressed("number4"):
		numpad["4"].click()
	elif Input.is_action_just_pressed("number5"):
		numpad["5"].click()
	elif Input.is_action_just_pressed("number6"):
		numpad["6"].click()
	elif Input.is_action_just_pressed("number7"):
		numpad["7"].click()
	elif Input.is_action_just_pressed("number8"):
		numpad["8"].click()
	elif Input.is_action_just_pressed("number9"):
		numpad["9"].click()
	elif Input.is_action_just_pressed("backspace"):
		numpad["backspace"].click()
	elif Input.is_action_just_pressed("accept"):
		if str(operations[_currentOp].res) == password.text:
			sfxs["correct_answer"].play()
			if(_currentOp == operations.size()-1):
				print('Next level!')
				_generate_next_level()

			_currentOp+=1
			self._change_question_text('%s + %s = ?' % [operations[_currentOp].a, operations[_currentOp].b])
			password.text = ''
		else:
			sfxs["wrong_answer"].play()
			password.text = ''

func _generate_next_level():
	match _currentLevel:
		0:
			operations.append_array(sumGenerator.gen_one_digit_unrestricted(2))
		1:
			operations.append_array(sumGenerator.gen_two_digit_restricted(2))
		2:
			operations.append_array(sumGenerator.gen_two_digit_unrestricted(2))
		3:
			operations.append_array(sumGenerator.gen_three_digit_restricted(2))
		4:
			operations.append_array(sumGenerator.gen_three_digit_unrestricted(2))
		_:
			print('No more levels to generate')
			return
	_currentLevel+=1

func _set_question_style(text: String):
	return "[center][color=#238531][wave amp=15 freq=2]%s[/wave][/color][/center]" % text

func _change_question_text(newText: String):
	question.clear()
	question.append_text(self._set_question_style(newText))
