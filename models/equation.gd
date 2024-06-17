extends Control

# Variables
@onready var label = $RichTextLabel
var sumGenerator: SumGenerator
var _level: int
var _equations: Array
var _equation_index: int

# Signals
signal level_finished

func _ready():
	# Get current level from Time Attack Manager
	if TimeAttackManager.equation_level:
		_level = TimeAttackManager.equation_level
	else:
		_level = 0

	# Initialize game seed
	if TimeAttackManager.match_seed != null:
		sumGenerator = SumGenerator.new(TimeAttackManager.match_seed)
	else:
		sumGenerator = SumGenerator.new(null)
		TimeAttackManager.match_seed = sumGenerator.rng.seed
	
	_equations = _generate_equations()
	_equation_index = 0
	_set_text()

func _generate_equations() -> Array:
	match TimeAttackManager.current_equation_type:
		TimeAttackManager.EquationType.SUM:
			match _level as TimeAttackManager.BasicLevels:
				TimeAttackManager.BasicLevels.one_digit_unres:
					return sumGenerator.gen_one_digit_unrestricted(3)
				TimeAttackManager.BasicLevels.two_digit_res:
					return sumGenerator.gen_two_digit_restricted(3)
				TimeAttackManager.BasicLevels.two_digit_unres:
					return sumGenerator.gen_two_digit_unrestricted(3)
				TimeAttackManager.BasicLevels.three_digit_res:
					return sumGenerator.gen_three_digit_restricted(3)
				TimeAttackManager.BasicLevels.three_digit_unres:
					return sumGenerator.gen_three_digit_unrestricted(3)
				_:
					return sumGenerator.gen_one_digit_restricted(3)
		_:
			return sumGenerator.gen_one_digit_restricted(3)

func _set_text():
	label.clear()
	var opening_tags: String = "[center][color=#238531][wave amp=15 freq=2]"
	var closing_tags: String = "[/wave][/color][/center]"
	var newText = "%s + %s = ?" % [_equations[_equation_index].a,_equations[_equation_index].b]
	label.append_text(opening_tags + newText + closing_tags)

func is_answer_correct(answer: String) -> bool:
	return str(_equations[_equation_index].res) == answer

func next():
	_equation_index+=1
	if _equation_index < _equations.size():
		_set_text()
	elif _equation_index >= _equations.size():
		level_finished.emit()
