extends Control

enum NUMPADKEYS  {
	number0,
	number1,
	number2,
	number3,
	number4,
	number5,
	number6,
	number7,
	number8,
	number9,
	backspace,
	change_sign
}

# Variables
@onready var answerLabel = $password/Label
@onready var equation = $equation
@onready var timer = $timer
@onready var sfx_manager = $sfx_manager

func _ready():
	# TODO: Get sum type from time attack manager
	for key in self.find_child("numpad").get_children():
		key.clicked.connect(_on_numpad_clicked)

	equation.level_finished.connect(_on_level_finished)

func _input(_event):
	if Input.is_action_just_pressed('accept'):
		if equation.is_answer_correct(answerLabel.text):
			sfx_manager.play_sound("correct_answer")
			equation.next()
		else:
			sfx_manager.play_sound("wrong_answer")
		answerLabel.text = ""

func _on_numpad_clicked(buttonName):
	var button = NUMPADKEYS[buttonName]
	
	if button == NUMPADKEYS.backspace:
		if answerLabel.text.is_empty():
			print_debug("Label is empty")
			sfx_manager.play_sound("error")
			return
		else:
			answerLabel.text = answerLabel.text.erase(answerLabel.text.length()-1)
	elif button == NUMPADKEYS.change_sign:
		if not answerLabel.text.is_empty() and answerLabel.text[0] == "-":
			answerLabel.text = answerLabel.text.erase(0)
		else:
			answerLabel.text = "-" + answerLabel.text
	else:
		answerLabel.text+=str(button)
		
	sfx_manager.play_sound("click")

func _on_level_finished():
	timer.save_time()
	TimeAttackManager.increase_equation_level()

	# TODO: Instantiate scene transition from scene manager
	SceneManager.load_scene("next level")
