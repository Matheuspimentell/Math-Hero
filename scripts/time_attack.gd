extends Control

@onready var pc_screen = $pc_screen
#TODO: Add time attack logic

# option (sum_enabled, subtraction_enabled, multiplication_enabled, division_enabled) == 0 -> enabled

enum Type { sum, subtraction, multiplication, division }
# Level.values().has(0) -> check if value exists inside levels enum
# Level.find_key(enabled_types[current_level]) -> get current level name

var enabled_types: Array = []

var current_eq_type: int = 0
var current_eq_level: int = 0

var equations: Array = []
var current_equation: int = 0
var quantity_each_equation_level: int = 1

func _ready():
	get_eq_types()
	equations = get_equations(quantity_each_equation_level) # Preenche o array equations com X equações de cada tipo habilitado
	set_equation_text()

func _input(event):
	if event.is_action_released("accept") and is_correct():
		print_debug("correct answer")
		current_equation+=1
		set_equation_text()
		pc_screen.set_answer_text("")
	elif event.is_action_released("accept") and not is_correct():
		pc_screen.add_error()
		print_debug(pc_screen.errors)
		pc_screen.set_answer_text("")
		#TODO: add sounds

func is_correct() -> bool:
	print_debug("Type: %s | Level: %d | Equation: %d" % [Type.find_key(enabled_types[current_eq_type]), current_eq_level, current_equation])
	return str(equations[current_equation].res) == pc_screen.get_answer_text()

func set_equation_text() -> void:
	# TODO: Check if passed last equation in equations array
	if current_equation >= equations.size():
		next_eq_level()
		equations = get_equations(quantity_each_equation_level)
		current_equation = 0
		set_equation_text()

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
	if GameManager.tattack_options["subtraction_enabled"] == 0:
		enabled_types.append(Type.subtraction)
	if GameManager.tattack_options["multiplication_enabled"] == 0:
		enabled_types.append(Type.multiplication)
	if GameManager.tattack_options["division_enabled"] == 0:
		enabled_types.append(Type.division)

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
			print_debug("not known equation level...")
			return

func get_equations(quantity_each: int) -> Array:
	match Type.find_key(enabled_types[current_eq_type]):
		"sum":
			return get_sum_equations(quantity_each)
		"subtraction":
			return get_subtraction_equations(quantity_each)
		"multiplication":
			return get_multiplication_equations(quantity_each)
		"division":
			return get_division_equations(quantity_each)
		_:
			print_debug("Equation level not found in enabled levels.")
	return []

func get_sum_equations(quantity: int) -> Array:
	match Sum.Level.find_key(current_eq_level):
		"odr":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_one_digit_restricted(quantity)
		"odu":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_one_digit_unrestricted(quantity)
		"twdr":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_two_digit_restricted(quantity)
		"twdu":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_two_digit_unrestricted(quantity)
		"tdr":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_three_digit_restricted(quantity)
		"tdu":
			return Sum.new(GameManager.tattack_options.get("seed")).gen_three_digit_unrestricted(quantity)
		_:
			return []

func get_subtraction_equations(quantity: int) -> Array:
	match Subtraction.Level.find_key(current_eq_level):
		"twdr":
			return Subtraction.new(GameManager.tattack_options.get("seed")).gen_two_digit_restricted(quantity)
		"twdu":
			return Subtraction.new(GameManager.tattack_options.get("seed")).gen_two_digit_unrestricted(quantity)
		"tdr":
			return Subtraction.new(GameManager.tattack_options.get("seed")).gen_three_digit_restricted(quantity)
		"tdu":
			return Subtraction.new(GameManager.tattack_options.get("seed")).gen_three_digit_unrestricted(quantity)
		"fot":
			return Subtraction.new(GameManager.tattack_options.get("seed")).gen_four_on_three(quantity)
		_:
			return []

func get_multiplication_equations(quantity: int) -> Array:
	match Multiplication.Level.find_key(current_eq_level):
		"bfi":
			return Multiplication.new(GameManager.tattack_options.get("seed")).gen_by_five(quantity)
		"be":
			return Multiplication.new(GameManager.tattack_options.get("seed")).gen_by_eleven(quantity)
		"twbo":
			return Multiplication.new(GameManager.tattack_options.get("seed")).gen_two_by_one(quantity)
		"tbo":
			return Multiplication.new(GameManager.tattack_options.get("seed")).gen_three_by_one(quantity)
		"twbtw":
			return Multiplication.new(GameManager.tattack_options.get("seed")).gen_two_by_two(quantity)
		_:
			return []

func get_division_equations(quantity: int) -> Array:
	match Division.Level.find_key(current_eq_level):
		"twbo":
			return Division.new(GameManager.tattack_options.get("seed")).gen_two_by_one(quantity)
		"tbo":
			return Division.new(GameManager.tattack_options.get("seed")).gen_three_by_one(quantity)
		"fbo":
			return Division.new(GameManager.tattack_options.get("seed")).gen_four_by_one(quantity)
		"tbtw":
			return Division.new(GameManager.tattack_options.get("seed")).gen_three_by_two(quantity)
		"fbtw":
			return Division.new(GameManager.tattack_options.get("seed")).gen_four_by_two(quantity)
		_:
			return []
