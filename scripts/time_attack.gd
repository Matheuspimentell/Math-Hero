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
	equations = get_equations() # Preenche o array equations com X equações de cada tipo habilitado
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
	return str(equations[current_equation].res) == pc_screen.get_answer_text()

func set_equation_text() -> void:
	# TODO: Check if passed last equation in equations array
	if current_equation >= equations.size():
		next_eq_level()
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

func next_eq_level() -> void:
	match Type.find_key(enabled_types[current_eq_type]):
		"sum":
			if current_eq_level >= Sum.Level.size():
				print_debug("Finished SUM levels")
				next_eq_type()
				current_eq_level = 0
				return
			else:
				current_eq_level+=1
				return
		"subtraction":
			if current_eq_level >= Subtraction.Level.size():
				print_debug("Finished SUBTRACTION levels")
				next_eq_type()
				current_eq_level = 0
				return
			else:
				current_eq_level+=1
				return
		"multiplication":
			if current_eq_level >= Multiplication.Level.size():
				print_debug("Finished MULTIPLICATION levels")
				next_eq_type()
				current_eq_level = 0
				return
			else:
				current_eq_level+=1
				return
		"division":
			if current_eq_level >= Division.Level.size():
				print_debug("Finished DIVISION levels")
				next_eq_type()
				current_eq_level = 0
				return
			else:
				current_eq_level+=1
				return
		_:
			print_debug("unknown equation type!")
			return

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
	match Sum.Level.find_key(current_eq_level):
		"odr":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_one_digit_restricted(3)
		"odu":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_one_digit_unrestricted(2)
		"twdr":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_two_digit_restricted(2)
		"twdu":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_two_digit_unrestricted(1)
		"tdr":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_three_digit_restricted(1)
		"tdu":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_three_digit_unrestricted(1)
		_:
			return []

func get_subtraction_equations() -> Array:
	match Subtraction.Level.find_key(current_eq_level):
		"twdr":
			return Subtraction.new(GameManager.tattack_options.get("seed")).gen_two_digit_restricted(3)
		"twdu":
			return Subtraction.new(GameManager.tattack_options.get("seed")).gen_two_digit_unrestricted(3)
		"tdr":
			return Subtraction.new(GameManager.tattack_options.get("seed")).gen_three_digit_restricted(2)
		"tdu":
			return Subtraction.new(GameManager.tattack_options.get("seed")).gen_three_digit_unrestricted(1)
		"fot":
			return Subtraction.new(GameManager.tattack_options.get("seed")).gen_four_on_three(1)
		_:
			return []

func get_multiplication_equations() -> Array:
	match Multiplication.Level.find_key(current_eq_level):
		"bfi":
			return Multiplication.new(GameManager.tattack_options.get("seed")).gen_by_five(3)
		"be":
			return Multiplication.new(GameManager.tattack_options.get("seed")).gen_by_eleven(3)
		"twbo":
			return Multiplication.new(GameManager.tattack_options.get("seed")).gen_two_by_one(2)
		"tbo":
			return Multiplication.new(GameManager.tattack_options.get("seed")).gen_three_by_one(1)
		"twbtw":
			return Multiplication.new(GameManager.tattack_options.get("seed")).gen_two_by_two(1)
		_:
			return []

func get_division_equations() -> Array:
	match Division.Level.find_key(current_eq_level):
		"twbo":
			return Division.new(GameManager.tattack_options.get("seed")).gen_two_by_one(3)
		"tbo":
			return Division.new(GameManager.tattack_options.get("seed")).gen_three_by_one(3)
		"fbo":
			return Division.new(GameManager.tattack_options.get("seed")).gen_four_by_one(2)
		"tbtw":
			return Division.new(GameManager.tattack_options.get("seed")).gen_three_by_two(1)
		"fbtw":
			return Division.new(GameManager.tattack_options.get("seed")).gen_four_by_two(1)
		_:
			return []

func finish_time_attack() -> void:
	# Finished enabled equation levels
	# Generate save data and transition to time attack results screen
	pc_screen.timer.stop()
	GameManager.tattack_results["time"] = pc_screen.timer.get_time()
	GameManager.tattack_results["errors"] = pc_screen.errors
	GameManager.tattack_results["seed"] = GameManager.tattack_options["seed"]
	SfxManager.stop("time_attack_background")
	GameManager.change_scene(time_attack_results_scene)
