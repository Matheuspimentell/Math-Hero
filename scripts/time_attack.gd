extends Control

@onready var pc_screen = $pc_screen
#TODO: Add time attack logic

# option (sum_enabled, subtraction_enabled, multiplication_enabled, division_enabled) == 0 -> enabled

enum Level { sum, subtraction, multiplication, division }
# Level.values().has(0) -> check if value exists inside levels enum
# Level.find_key(enabled_levels[current_level]) -> get current level name

var enabled_levels: Array = []

var current_eq_type: int = Level.sum # Set to sum
var current_eq_level: int = Sum.Level.odr # Set to initial level on sum (one digit restriscted)

var equations: Array = []
var current_equation: int = 0

func _ready():
	get_eq_types()
	set_eq_type(0)
	get_equations(2) # Preenche o array equations com X equações de cada tipo habilitado
	print(equations)
	set_equation_text()

func set_equation_text() -> void:
	match Level.find_key(enabled_levels[current_eq_level]):
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
		enabled_levels.append(Level.sum)
	if GameManager.tattack_options["subtraction_enabled"] == 0:
		enabled_levels.append(Level.subtraction)
	if GameManager.tattack_options["multiplication_enabled"] == 0:
		enabled_levels.append(Level.multiplication)
	if GameManager.tattack_options["division_enabled"] == 0:
		enabled_levels.append(Level.division)

func set_eq_type(next_type: int) -> void:
	current_eq_type = next_type
	current_eq_type = enabled_levels[current_eq_type]

func next_eq_level() -> void:
	match Level.find_key(enabled_levels[current_eq_type]):
		"sum":
			if current_eq_level >= Sum.Level.size():
				set_eq_type(current_eq_type+1)
				current_eq_level = 0
			else:
				current_eq_level+=1
		"subtraction":
			if current_eq_level >= Subtraction.Level.size():
				set_eq_type(current_eq_type+1)
				current_eq_level = 0
			else:
				current_eq_level+=1
		"multiplication":
			if current_eq_level >= Multiplication.Level.size():
				set_eq_type(current_eq_type+1)
				current_eq_level = 0
			else:
				current_eq_level+=1
		"division":
			if current_eq_level >= Division.Level.size():
				set_eq_type(current_eq_type+1)
				current_eq_level = 0
			else:
				current_eq_level+=1
		_:
			print_debug("not known equation level...")

func get_equations(quantity_each: int) -> void:
	for level in enabled_levels:
		match Level.find_key(level):
			"sum":
				equations.append_array(get_sum_equations(quantity_each))
			"subtraction":
				equations.append_array(get_subtraction_equations(quantity_each))
			"multiplication":
				equations.append_array(get_multiplication_equations(quantity_each))
			"division":
				equations.append_array(get_division_equations(quantity_each))
			_:
				print_debug("Equation level not found in enabled levels.")

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
