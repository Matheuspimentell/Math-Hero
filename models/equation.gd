extends Control

enum levels {
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
var current_level = levels.one_digit_res
var _equations: Array
var _equation_index: int = 0

# Signals
signal level_finished

func _ready():
	# Initialize game seed
	if TimeAttackManager.match_seed:
		sumGenerator = SumGenerator.new(TimeAttackManager.match_seed)
	else:
		sumGenerator = SumGenerator.new(null)
		TimeAttackManager.match_seed = sumGenerator.rng.seed
	
	_equations = _generate_equations()
	_set_text()

func _generate_equations() -> Array:
	match current_level:
		levels.one_digit_unres:
			return sumGenerator.gen_one_digit_unrestricted(6)
		levels.two_digit_res:
			return sumGenerator.gen_two_digit_restricted(6)
		levels.two_digit_unres:
			return sumGenerator.gen_two_digit_unrestricted(6)
		levels.three_digit_res:
			return sumGenerator.gen_three_digit_restricted(6)
		levels.three_digit_unres:
			return sumGenerator.gen_three_digit_unrestricted(6)
		_:
			return sumGenerator.gen_one_digit_restricted(6)

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
		current_level = (current_level+1) as levels
		level_finished.emit()
