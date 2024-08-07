@tool
class_name Subtraction

# Variables
var rng = RandomNumberGenerator.new()

enum Level {twdr, twdu, tdr, tdu, fot}

func _init(game_seed: String):
	self.rng.seed = hash(game_seed)

func gen_two_digit_unrestricted(quantity: int) -> Array:
	var operations: Array = []

	for a in range(10,99):
		for b in range(10,99):
			if(a-b>=0):
				operations.append({ 'a': a, 'b': b, 'res': (a-b) })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_two_digit_restricted(quantity: int) -> Array:
	var operations: Array = []
	for a in range(10,99):
		for b in range(10,99):
			if((a-b>=0) and ((a/10)>=(b/10))):
				operations.append({ 'a': a, 'b': b, 'res': (a-b) })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_three_digit_unrestricted(quantity: int) -> Array:
	var operations: Array = []

	for a in range(100,999):
		for b in range(100,999):
			if(a-b>=0):
				operations.append({ 'a': a, 'b': b, 'res': (a-b) })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_three_digit_restricted(quantity: int) -> Array:
	var operations: Array = []
	for a in range(100,999):
		for b in range(100,999):
			if((a-b>=0) and ((a%100)>(b%100)) and ((a%10)-(b%10)>=0)):
				operations.append({ 'a': a, 'b': b, 'res': (a-b) })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_four_on_three(quantity: int) -> Array:
	var operations: Array = []

	for x in range(quantity):
		var a = self.rng.randi_range(1000,9999)
		var b = self.rng.randi_range(100,999)
		operations.append({ 'a': a, 'b': b, 'res': (a-b) })

	return operations.slice(0, quantity)
