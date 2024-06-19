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
	backspace
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
			answerLabel.text = ""
		else:
			answerLabel.text = ""
			sfx_manager.play_sound("wrong_answer")

func _on_numpad_clicked(buttonName):
	var button = NUMPADKEYS[buttonName]
	
	if button == NUMPADKEYS.backspace:
		if answerLabel.text.is_empty():
			print_debug("Label is empty")
			sfx_manager.play_sound("error")
			return
		else:
			answerLabel.text = answerLabel.text.erase(answerLabel.text.length()-1, 1)
	else:
		answerLabel.text+=str(button)
		
	sfx_manager.play_sound("click")

func _on_level_finished():
	timer.save_time()
	match TimeAttackManager.current_equation_type:	
		TimeAttackManager.EquationType.MULTIPLICATION:
			pass
		TimeAttackManager.EquationType.DIVISION:
			pass
		_:
			if TimeAttackManager.equation_level < TimeAttackManager.BasicLevels.values().size():
				TimeAttackManager.equation_level += 1
			else:
				# TODO: Change equation type for competition mode
				get_tree().quit()
				
	# TODO: Instantiate scene transition from scene manager
	SceneManager.load_scene("time_attack")