@tool
class_name MultGenerator

# Variables
var rng = RandomNumberGenerator.new()
var ascii = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

func _init(generator_seed):
	if generator_seed == null:
		self.rng.seed = hash(self._gen_unique_hash(10));
	else:
		self.rng.seed = generator_seed

func _gen_unique_hash(length: int):
	var result = ''
	for i in range(length):
		result += ascii[randi() % ascii.length()]
	return result

func gen_two_by_one(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(10,99)
		var b = self.rng.randf_range(0,9)
		operations.append({'a': a, 'b': b, 'res': a*b})

	return operations

func gen_three_by_one(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(100,999)
		var b = self.rng.randf_range(0,9)
		operations.append({'a': a, 'b': b, 'res': a*b})

	return operations

func gen_two_by_two(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(10,99)
		var b = self.rng.randf_range(10,99)
		operations.append({'a': a, 'b': b, 'res': a*b})

	return operations

func gen_by_five(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(0,999)
		operations.append({'a': a, 'b': 5, 'res': a*5})

	return operations

func gen_by_eleven(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(0,999)
		operations.append({'a': a, 'b': 11, 'res': a*11})

	return operations
