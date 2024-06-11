extends Control

enum equation_types {
	one_digit_res,
	one_digit_unres,
	two_digit_res,
	two_digit_unres,
	three_digit_res,
	three_digit_unres
}

# Variables
@onready var label = $RichTextLabel
var sumGenerator: SumGenerator
var current_level = equation_types.one_digit_res
var equations: Array
var _current_equation: int = 0

# Signals
signal level_finished

func _ready():
	# Initialize game seed
	if TimeAttackManager.match_seed:
		sumGenerator = SumGenerator.new(TimeAttackManager.match_seed)
	else:
		sumGenerator = SumGenerator.new(null)
		TimeAttackManager.match_seed = sumGenerator.rng.seed
	
	equations = _generate_equations()
	_set_text()

func _generate_equations() -> Array:
	match current_level:
		equation_types.one_digit_unres:
			return sumGenerator.gen_one_digit_unrestricted(10)
		equation_types.two_digit_res:
			return sumGenerator.gen_two_digit_restricted(10)
		equation_types.two_digit_unres:
			return sumGenerator.gen_two_digit_unrestricted(10)
		equation_types.three_digit_res:
			return sumGenerator.gen_three_digit_restricted(10)
		equation_types.three_digit_unres:
			return sumGenerator.gen_three_digit_unrestricted(10)
		_:
			return sumGenerator.gen_one_digit_restricted(10)

func _set_text():
	label.clear()
	var opening_tags: String = "[center][color=#238531][wave amp=15 freq=2]"
	var closing_tags: String = "[/wave][/color][/center]"
	var newText = "%s + %s = ?" % [equations[_current_equation].a,equations[_current_equation].b]
	label.append_text(opening_tags + newText + closing_tags)

func is_answer_correct(answer: String) -> bool:
	if str(equations[_current_equation].res) == answer:
		return true
	else:
		return false

func next():
	_current_equation+=1
	if _current_equation < equations.size():
		_set_text()
	elif _current_equation >= equations.size():
		level_finished.emit()
