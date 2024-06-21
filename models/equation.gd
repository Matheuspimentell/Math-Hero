extends Control

# Variables
@onready var label = $RichTextLabel
var sumGenerator: SumGenerator
var subGenerator: SubGenerator
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

	_init_generators()
	
	_equations = _generate_equations(2)
	_equation_index = 0
	_set_text()

func _init_generators():
	if TimeAttackManager.match_seed != null:
		sumGenerator = SumGenerator.new(TimeAttackManager.match_seed)
		subGenerator = SubGenerator.new(TimeAttackManager.match_seed)
	else:
		sumGenerator = SumGenerator.new(null)
		subGenerator = SubGenerator.new(sumGenerator.rng.seed)
		TimeAttackManager.match_seed = sumGenerator.rng.seed

func _generate_equations(quantity: int) -> Array:
	var new_equations: Array
	match TimeAttackManager.current_equation_type:
		TimeAttackManager.EquationType.SUM:
			new_equations = _generate_sum_equations(quantity)
		TimeAttackManager.EquationType.SUBTRACTION:
			new_equations = _generate_sub_equations(quantity)
		_:
			print_debug("Not known equation type!")
			new_equations = _generate_sum_equations(quantity)
		
	return new_equations

func _generate_sum_equations(quantity: int) -> Array:
	match _level as TimeAttackManager.SumLevels:
		TimeAttackManager.SumLevels.one_digit_unres:
			return sumGenerator.gen_one_digit_unrestricted(quantity)
		TimeAttackManager.SumLevels.two_digit_res:
			return sumGenerator.gen_two_digit_restricted(quantity)
		TimeAttackManager.SumLevels.two_digit_unres:
			return sumGenerator.gen_two_digit_unrestricted(quantity)
		TimeAttackManager.SumLevels.three_digit_res:
			return sumGenerator.gen_three_digit_restricted(quantity)
		TimeAttackManager.SumLevels.three_digit_unres:
			return sumGenerator.gen_three_digit_unrestricted(quantity)
		_:
			return sumGenerator.gen_one_digit_restricted(quantity)

func _generate_sub_equations(quantity: int) -> Array:
	match _level as TimeAttackManager.SubLevels:
		TimeAttackManager.SubLevels.two_digit_res:
			return subGenerator.gen_two_digit_restricted(quantity)
		TimeAttackManager.SubLevels.two_digit_unres:
			return subGenerator.gen_two_digit_unrestricted(quantity)
		TimeAttackManager.SubLevels.three_digit_res:
			return subGenerator.gen_three_digit_restricted(quantity)
		TimeAttackManager.SubLevels.three_digit_unres:
			return subGenerator.gen_three_digit_unrestricted(quantity)
		TimeAttackManager.SubLevels.four_on_three_digit:
			return subGenerator.gen_four_on_three(quantity)
		_:
			return subGenerator.gen_two_digit_restricted(quantity)

func _set_text():
	label.clear()
	var opening_tags: String = "[center][color=#238531][wave amp=15 freq=2]"
	var closing_tags: String = "[/wave][/color][/center]"

	var equation_format = "%s %s %s = ?"
	var new_text = ""
	match TimeAttackManager.current_equation_type:
		TimeAttackManager.EquationType.SUM:
			new_text = equation_format % [_equations[_equation_index].a,"+",_equations[_equation_index].b]
		TimeAttackManager.EquationType.SUBTRACTION:
			new_text = equation_format % [_equations[_equation_index].a,"-",_equations[_equation_index].b]
		TimeAttackManager.EquationType.MULTIPLICATION:
			new_text = equation_format % [_equations[_equation_index].a,"x",_equations[_equation_index].b]
		TimeAttackManager.EquationType.DIVISION:
			new_text = equation_format % [_equations[_equation_index].a,"/",_equations[_equation_index].b]
		_:
			new_text = "error!"

	label.append_text(opening_tags + new_text + closing_tags)

func is_answer_correct(answer: String) -> bool:
	return str(_equations[_equation_index].res) == answer

func next():
	_equation_index+=1
	if _equation_index < _equations.size():
		_set_text()
	elif _equation_index >= _equations.size():
		level_finished.emit()
