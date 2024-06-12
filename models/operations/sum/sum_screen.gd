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

func _ready():
	# TODO: Get sum type from time attack manager
	for key in self.find_child("numpad").get_children():
		key.clicked.connect(_on_numpad_clicked)

	equation.level_finished.connect(_on_level_finished)

func _input(_event):
	if Input.is_action_just_pressed('accept'):
		if equation.is_answer_correct(answerLabel.text):
			# TODO Send signal to sfx manager
			equation.next()
			answerLabel.text = ""
		else:
			answerLabel.text = ""
			# TODO: send signal to sfx manager

func _on_numpad_clicked(buttonName):
	var button = NUMPADKEYS[buttonName]
	if button == NUMPADKEYS.backspace:
		if not answerLabel.text.is_empty():
			answerLabel.text = answerLabel.text.erase(answerLabel.text.length()-1, 1)
			# TODO: Send signal to sfx manager
		else:
			# TODO: Send error signal to sfx manager
			print_debug("Label is empty")
	else:
		answerLabel.text+=str(button)
		# TODO: Send signal to sfx manager

func _on_level_finished():
	timer.save_timer()
	var final_time = TimeAttackManager.elapsed_time
	print("%03d:%02d.%03d" % [fmod(final_time,3600)/60,fmod(final_time,60),fmod(final_time,1)*1000])
	get_tree().quit()