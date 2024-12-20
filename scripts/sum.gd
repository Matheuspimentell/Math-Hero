@tool
class_name Sum

# Variables
var rng = RandomNumberGenerator.new()

enum Level {odr, onu, twdr, twdu, tdr, tdu}

func _init(game_seed: String):
	self.rng.seed = hash(game_seed)

func gen_one_digit_unrestricted(quantity: int) -> Array:
	var operations: Array = [];

	for x in range(quantity):
		var a = self.rng.randi_range(1,9)
		var b = self.rng.randi_range(1,9)
		operations.append({ 'a': a, 'b': b, 'res': (a+b) })

	return operations

func gen_one_digit_restricted(quantity: int) -> Array:
	var operations: Array = []

	for a in range(1,10):
		for b in range(1,10):
			if(a+b<10):
				operations.append({ 'a': a, 'b': b, 'res': (a+b) })

	seed(self.rng.seed) # Set @GlobalScope seed to be equal to game_seed
	operations.shuffle()
	randomize() # Unset @GlobalScope seed to random again

	return operations.slice(0, quantity)

func gen_two_digit_unrestricted(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(10, 99)
		var b = self.rng.randi_range(10, 99)
		operations.append({ 'a': a, 'b': b, 'res': (a+b) })

	return operations

func gen_two_digit_restricted(quantity: int) -> Array:
	var operations: Array = []
	for a in range(10,99):
		for b in range(10,99):
			if(((a%10)+(b%10)<10) and (a/10)+(b/10)<10):
				operations.append({ 'a': a, 'b': b, 'res': (a+b) })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)

func gen_three_digit_unrestricted(quantity: int) -> Array:
	var operations: Array = []

	for i in range(quantity):
		var a = self.rng.randi_range(100, 999)
		var b = self.rng.randi_range(100, 999)
		operations.append({ 'a': a, 'b': b, 'res': (a+b) })

	return operations

func gen_three_digit_restricted(quantity: int) -> Array:
	var operations: Array = []
	for a in range(100,999):
		for b in range(100,999):
			if(((a%10)+(b%10)<10) and ((a%100)+(b%100)<10) and ((a/100)+(b/100)<10)):
				operations.append({ 'a': a, 'b': b, 'res': (a+b) })

	seed(self.rng.seed)
	operations.shuffle()
	randomize()

	return operations.slice(0, quantity)
