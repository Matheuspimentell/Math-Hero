extends Control

@onready var pc_screen = $pc_screen
const time_attack_results_scene = "res://scenes/time_attack_results.tscn"
const main_menu = "res://scenes/main_menu.tscn"

# option (sum_enabled, subtraction_enabled, multiplication_enabled, division_enabled) == 0 -> enabled

enum Type { sum, subtraction, multiplication, division }
# Level.values().has(0) -> check if value exists inside levels enum
# Level.find_key(enabled_types[current_level]) -> get current level name

var enabled_types: Array = []

var current_eq_type: int = 0
var current_eq_level: int = 0

var equations: Array = []
var current_equation: int = 0
var equation_levels_amount: int = 2

func _ready():
	SfxManager.play("time_attack_background")
	get_eq_types()
	equations = get_equations() # Get all equations based on current level or current difficulty
	set_equation_text()

func _input(event):
	if event.is_action_released("ui_cancel"):
		# TODO implement pause logic
		SfxManager.stop("time_attack_background")
		GameManager.change_scene(main_menu)
		return
	if event.is_action_released("accept") and is_correct():
		print_debug("correct answer")
		SfxManager.play("correct")
		current_equation+=1
		set_equation_text()
		pc_screen.set_answer_text("")
	elif event.is_action_released("accept") and not is_correct():
		print_debug(pc_screen.errors)
		SfxManager.play("error")
		pc_screen.add_error()
		pc_screen.set_answer_text("")

func is_correct() -> bool:
	print_debug("Type: %s | Level: %d | Equation: %d" % [Type.find_key(enabled_types[current_eq_type]), current_eq_level, current_equation])
	print_debug("Result: %d" % equations[current_equation].res)
	return str(equations[current_equation].res) == pc_screen.get_answer_text()

func set_equation_text() -> void:
	# TODO: Check if passed last equation in equations array
	if current_equation >= equations.size():
		next_eq_type()
		if current_eq_type >= enabled_types.size():
			print_debug("has finished time attack... will change scene")
			finish_time_attack()
			return
		equations = get_equations()
		current_equation = 0
		set_equation_text()

	if current_eq_type < enabled_types.size():
		match Type.find_key(enabled_types[current_eq_type]):
			"sum":
				pc_screen.set_question_text("%d + %d = ?" % [equations[current_equation].a, equations[current_equation].b])
			"subtraction":
				pc_screen.set_question_text("%d - %d = ?" % [equations[current_equation].a, equations[current_equation].b])
			"multiplication":
				pc_screen.set_question_text("%d x %d = ?" % [equations[current_equation].a, equations[current_equation].b])
			"division":
				pc_screen.set_question_text("%d / %d = ?" % [equations[current_equation].a, equations[current_equation].b])
			_:
				print_debug("Not known equation level.")

func get_eq_types() -> void:
	if GameManager.tattack_options["sum_enabled"] == 0:
		enabled_types.append(Type.sum)
		GameManager.tattack_results["sum"] = true
	else:
		GameManager.tattack_results["sum"] = false
	if GameManager.tattack_options["subtraction_enabled"] == 0:
		enabled_types.append(Type.subtraction)
		GameManager.tattack_results["sub"] = true
	else:
		GameManager.tattack_results["sub"] = false
	if GameManager.tattack_options["multiplication_enabled"] == 0:
		enabled_types.append(Type.multiplication)
		GameManager.tattack_results["mul"] = true
	else:
		GameManager.tattack_results["mul"] = false
	if GameManager.tattack_options["division_enabled"] == 0:
		enabled_types.append(Type.division)
		GameManager.tattack_results["div"] = true
	else:
		GameManager.tattack_results["div"] = false

func next_eq_type() -> void:
	current_eq_type+=1

func get_equations() -> Array:
	match Type.find_key(enabled_types[current_eq_type]):
		"sum":
			return get_sum_equations()
		"subtraction":
			return get_subtraction_equations()
		"multiplication":
			return get_multiplication_equations()
		"division":
			return get_division_equations()
		_:
			print_debug("Equation level not found in enabled levels.")
	return []

func get_sum_equations() -> Array:
	# TODO: check game difficulty, and generate equations

	var sumEquations: Array = []
	var difficultyLevel: int = GameManager.tattack_options.get("difficulty")
	var generator: Sum = Sum.new(GameManager.tattack_options.get("seed"))

	# Beginner
	if difficultyLevel == 0:
		sumEquations.append_array(generator.gen_one_digit_restricted(5))
		sumEquations.append_array(generator.gen_one_digit_unrestricted(3))
		sumEquations.append_array(generator.gen_two_digit_restricted(2))
	# Easy
	elif difficultyLevel == 1:
		sumEquations.append_array(generator.gen_one_digit_restricted(2))
		sumEquations.append_array(generator.gen_one_digit_unrestricted(3))
		sumEquations.append_array(generator.gen_two_digit_restricted(3))
		sumEquations.append_array(generator.gen_two_digit_unrestricted(2))
	# Medium
	elif difficultyLevel == 2:
		sumEquations.append_array(generator.gen_two_digit_restricted(5))
		sumEquations.append_array(generator.gen_two_digit_restricted(5))
		sumEquations.append_array(generator.gen_three_digit_restricted(2))
	# Hard
	elif difficultyLevel == 3:
		sumEquations.append_array(generator.gen_two_digit_restricted(2))
		sumEquations.append_array(generator.gen_two_digit_unrestricted(3))
		sumEquations.append_array(generator.gen_three_digit_restricted(3))
		sumEquations.append_array(generator.gen_three_digit_unrestricted(2))
	# Very Hard
	else:
		sumEquations.append_array(generator.gen_two_digit_restricted(2))
		sumEquations.append_array(generator.gen_two_digit_unrestricted(3))
		sumEquations.append_array(generator.gen_three_digit_restricted(3))
		sumEquations.append_array(generator.gen_three_digit_unrestricted(2))

	return sumEquations

func get_subtraction_equations() -> Array:
	# TODO: check game difficulty, and generate equations

	var subEquations: Array = []
	var difficultyLevel: int = GameManager.tattack_options.get("difficulty")
	var generator: Subtraction = Subtraction.new(GameManager.tattack_options.get("seed"))

	# Beginner
	if difficultyLevel == 0:
		subEquations.append_array(generator.gen_one_by_one(5))
		subEquations.append_array(generator.gen_multipleoften_by_one(3))
		subEquations.append_array(generator.gen_two_by_one_restricted(2))
	# Easy
	elif difficultyLevel == 1:
		subEquations.append_array(generator.gen_one_by_one(2))
		subEquations.append_array(generator.gen_multipleoften_by_one(3))
		subEquations.append_array(generator.gen_two_by_one_restricted(3))
		subEquations.append_array(generator.gen_two_by_one_unrestricted(2))
	# Medium
	elif difficultyLevel == 2:
		subEquations.append_array(generator.gen_multipleoften_by_one(2))
		subEquations.append_array(generator.gen_multipleofahundred_by_two(3))
		subEquations.append_array(generator.gen_two_digit_unrestricted(3))
		subEquations.append_array(generator.gen_three_by_two_restricted(2))
	# Hard
	elif difficultyLevel == 3:
		subEquations.append_array(generator.gen_multipleofahundred_by_two(2))
		subEquations.append_array(generator.gen_multipleofathousand_by_three(3))
		subEquations.append_array(generator.gen_three_by_two_restricted(3))
		subEquations.append_array(generator.gen_three_by_two_unrestricted(2))
	# Very Hard
	else:
		subEquations.append_array(generator.gen_multipleofahundred_by_two(2))
		subEquations.append_array(generator.gen_multipleofathousand_by_three(3))
		subEquations.append_array(generator.gen_three_by_two_restricted(3))
		subEquations.append_array(generator.gen_three_by_two_unrestricted(2))

	return subEquations

func get_multiplication_equations() -> Array:
	# TODO: check game difficulty, and generate equations

	var multiplyEquations: Array = []
	var difficultyLevel: int = GameManager.tattack_options.get("difficulty")
	var generator: Multiplication = Multiplication.new(GameManager.tattack_options.get("seed"))

	# Beginner
	if difficultyLevel == 0:
		multiplyEquations.append_array(generator.gen_one_by_one(5))
		multiplyEquations.append_array(generator.gen_one_by_eleven_restricted(3))
		multiplyEquations.append_array(generator.gen_two_by_eleven_restricted(2))
	# Easy
	elif difficultyLevel == 1:
		multiplyEquations.append_array(generator.gen_one_by_one(3))
		multiplyEquations.append_array(generator.gen_one_by_eleven_restricted(2))
		multiplyEquations.append_array(generator.gen_two_by_eleven_restricted(3))
		multiplyEquations.append_array(generator.gen_two_by_eleven_unrestricted(2))
	# Medium
	elif difficultyLevel == 2:
		multiplyEquations.append_array(generator.gen_two_by_eleven_restricted(3))
		multiplyEquations.append_array(generator.gen_two_by_eleven_unrestricted(2))
		multiplyEquations.append_array(generator.gen_one_by_fiveinunitsplace(2))
		multiplyEquations.append_array(generator.gen_one_by_fiveintensplace(3))
	# Hard
	elif difficultyLevel == 3:
		multiplyEquations.append_array(generator.gen_two_by_eleven_unrestricted(2))
		multiplyEquations.append_array(generator.gen_three_by_eleven_restricted(2))
		multiplyEquations.append_array(generator.gen_three_by_eleven_unrestricted(3))
		multiplyEquations.append_array(generator.gen_two_by_two(4))
	# Very Hard
	else:
		multiplyEquations.append_array(generator.gen_three_by_eleven_restricted(2))
		multiplyEquations.append_array(generator.gen_three_by_one(2))
		multiplyEquations.append_array(generator.gen_two_by_two(3))
		multiplyEquations.append_array(generator.gen_three_by_three(3))

	return multiplyEquations

func get_division_equations() -> Array:
	# TODO: check game difficulty, and generate equations

	var divisionEquations: Array = []
	var difficultyLevel: int = GameManager.tattack_options.get("difficulty")
	var generator: Division = Division.new(GameManager.tattack_options.get("seed"))

	# Beginner
	if difficultyLevel == 0:
		divisionEquations.append_array(generator.gen_two_by_one(5))
		divisionEquations.append_array(generator.gen_two_by_two(3))
		divisionEquations.append_array(generator.gen_two_by_five(2))
	# Easy
	elif difficultyLevel == 1:
		divisionEquations.append_array(generator.gen_two_by_one(3))
		divisionEquations.append_array(generator.gen_two_by_two(3))
		divisionEquations.append_array(generator.gen_two_by_five(3))
		divisionEquations.append_array(generator.gen_three_by_numtwo(2))
	# Medium
	elif difficultyLevel == 2:
		divisionEquations.append_array(generator.gen_two_by_numtwo(2))
		divisionEquations.append_array(generator.gen_three_by_numtwo(2))
		divisionEquations.append_array(generator.gen_two_by_five(2))
		divisionEquations.append_array(generator.gen_three_by_five(2))
		divisionEquations.append_array(generator.gen_three_by_two(2))
	# Hard
	elif difficultyLevel == 3:
		divisionEquations.append_array(generator.gen_three_by_numtwo(2))
		divisionEquations.append_array(generator.gen_four_by_numtwo(2))
		divisionEquations.append_array(generator.gen_three_by_one(3))
		divisionEquations.append_array(generator.gen_three_by_two(3))
	# Very Hard
	else:
		divisionEquations.append_array(generator.gen_three_by_numtwo(2))
		divisionEquations.append_array(generator.gen_four_by_numtwo(2))
		divisionEquations.append_array(generator.gen_three_by_one(3))
		divisionEquations.append_array(generator.gen_three_by_two(3))

	return divisionEquations

func finish_time_attack() -> void:
	# Finished enabled equation levels
	# Generate save data and transition to time attack results screen
	pc_screen.timer.stop()
	GameManager.tattack_results["time"] = pc_screen.timer.get_time()
	GameManager.tattack_results["errors"] = pc_screen.errors
	GameManager.tattack_results["seed"] = GameManager.tattack_options["seed"]
	SfxManager.stop("time_attack_background")
	GameManager.change_scene(time_attack_results_scene)
