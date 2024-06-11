extends Node2D

# enum NUMPADKEYS  {
# 	number0,
# 	number1,
# 	number2,
# 	number3,
# 	number4,
# 	number5,
# 	number6,
# 	number7,
# 	number8,
# 	number9,
# 	backspace
# }

var sumGenerator: SumGenerator
var equations: Array
@onready var equationLabel = $equation/RichTextLabel

func _ready():
	# Initialize sum generator seed
	if TimeAttackManager.match_seed:
		sumGenerator = SumGenerator.new(TimeAttackManager.match_seed)
	else:
		sumGenerator = SumGenerator.new(null)
		TimeAttackManager.match_seed = sumGenerator.rng.seed
	
	# TODO: Get sum type from mode manager
	equations = sumGenerator.gen_one_digit_restricted(10)
	equations.append_array(sumGenerator.gen_one_digit_unrestricted(10))

	# for key in self.find_child("numpad").get_children():
	# 	key.clicked.connect(self._on_numpad_clicked(NUMPADKEYS[key.buttonName]))
	pass

func _input(_event):
	if Input.is_action_just_pressed('accept'):
		#TODO: Check password with answer
		pass

# func _on_numpad_clicked(buttonName):
# 	# TODO: Send signal to password with button value
# 	pass