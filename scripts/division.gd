@tool
class_name Division

# Variables
var rng = RandomNumberGenerator.new()

enum Level {twbo, tbo, fbo, tbtw, fbtw}

func _init(game_seed: String):
	self.rng.seed = hash(game_seed)

func gen_two_by_one(quantity: int) -> Array:
	var operations: Array = []

	for a in range (10,99):
		for b in range (2,9):
			if a%b == 0:
				operations.append({ 'a': a, 'b': b, 'res': a/b })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)
	
func gen_two_by_two(quantity: int) -> Array:
	var operations: Array = []

	for a in range (10,99):
		for b in range (10,99):
			if a%b == 0:
				operations.append({ 'a': a, 'b': b, 'res': a/b })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_two_by_five(quantity: int) -> Array:
	var operations: Array = []

	for a in range (10,99):
		if a%5 == 0:
			operations.append({ 'a': a, 'b': 5, 'res': a/5 })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)
	
func gen_three_by_five(quantity: int) -> Array:
	var operations: Array = []

	for a in range (100,999):
		if a%5 == 0:
			operations.append({ 'a': a, 'b': 5, 'res': a/5 })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)
	
func gen_three_by_numtwo(quantity: int) -> Array:
	var operations: Array = []

	for a in range (100,999):
		if a%2 == 0:
			operations.append({ 'a': a, 'b': 2, 'res': a/2 })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_four_by_numtwo(quantity: int) -> Array:
	var operations: Array = []

	for a in range (1000,9999):
		if a%2 == 0:
			operations.append({ 'a': a, 'b': 2, 'res': a/2 })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_two_by_numtwo(quantity: int) -> Array:
	var operations: Array = []

	for a in range (10,99):
		if a%2 == 0:
			operations.append({ 'a': a, 'b': 2, 'res': a/2 })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_three_by_one(quantity: int) -> Array:
	var operations: Array = []

	for a in range(100,999):
		for b in range(2,9):
			if a%b == 0:
				operations.append({ 'a': a, 'b': b, 'res': a/b })

		seed(self.rng.seed)
		operations.shuffle()
		randomize()

	return operations.slice(0, quantity)

func gen_four_by_one(quantity: int) -> Array:
	var operations: Array = []

	for a in range(1000,9999):
		for b in range(2,9):
			if a%b == 0:
				operations.append({ 'a': a, 'b': b, 'res': a/b })

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

#TODO: Add divisões por 2 e por 5
