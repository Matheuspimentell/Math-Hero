@tool
class_name DivisionGenerator

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

	for a in range (10,99):
		for b in range (1,9):
			if a%b ==0:
				operations.append({'a': a, 'b': b, 'res': a/b})

	seed(self.rng.seed)
	operations.shuffle()
	randomize()
	
	return operations.slice(0, quantity)

func gen_three_by_one(quantity: int) -> Array:
	var operations: Array = []

	for a in range(100,999):
		for b in range(1,9):
			if a%b == 0:
				operations.append({'a': a, 'b': b, 'res': a/b})

		seed(self.rng.seed)
		operations.shuffle()
		randomize()

	return operations.slice(0, quantity)

func gen_four_by_one(quantity: int) -> Array:
	var operations: Array = []

	for a in range(1000,9999):
		for b in range(1,9):
			if a%b == 0:
				operations.append({'a': a, 'b': b, 'res': a/b})

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_three_by_two(quantity: int) -> Array:
	var operations: Array = []

	for a in range(100,999):
		for b in range(10,99):
			if a%b == 0:
				operations.append({'a': a, 'b': b, 'res': a/b})

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_four_by_two(quantity: int) -> Array:
	var operations: Array = []

	for a in range(1000,9999):
		for b in range(10,99):
			if a%b == 0:
				operations.append({'a': a, 'b': b, 'res': a/b})

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)