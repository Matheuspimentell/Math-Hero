@tool
class_name Multiplication

# Variables
var rng = RandomNumberGenerator.new()

enum Level {bfi, be, twbo, tbo, twbtw}

func _init(game_seed: String):
	self.rng.seed = hash(game_seed)

func gen_two_by_one(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a: int = self.rng.randi_range(10,99)
		var b: int = self.rng.randi_range(2,9)
		operations.append({'a': a, 'b': b, 'res': a*b})

	return operations

func gen_three_by_one(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(100,999)
		var b = self.rng.randi_range(2,9)
		operations.append({'a': a, 'b': b, 'res': a*b})

	return operations

func gen_two_by_two(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(10,99)
		var b = self.rng.randi_range(10,99)
		operations.append({'a': a, 'b': b, 'res': a*b})

	return operations

func gen_by_five(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(2,999)
		operations.append({'a': a, 'b': 5, 'res': a*5})

	return operations

func gen_by_eleven(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(2,999)
		operations.append({'a': a, 'b': 11, 'res': a*11})

	return operations

#TODO: Separação das multiplicações por 5 casos especiais e 11 casos esperar