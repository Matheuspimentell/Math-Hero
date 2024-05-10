class_name SumGenerator

var rng = RandomNumberGenerator.new()
var ascii = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

func _init(generator_seed):
	var game_seed: int = 0
	if !generator_seed:
		game_seed = hash(self._gen_unique_hash(10));
	else:
		game_seed = hash(generator_seed)
	
	self.rng.seed = game_seed
	print(game_seed)

func _gen_unique_hash(length: int):
	var result = ''
	for i in range(length):
		result += ascii[randi() % ascii.length()]
	return result
	
func gen_one_digit_unrestricted(quantity: int) -> Array:
	var operations: Array = [];

	for x in range(quantity):
		var a = self.rng.randi_range(0,10)
		var b = self.rng.randi_range(0,10)
		var res = a+b
		operations.append({ 'a': a, 'b': b, 'res': res })

	return operations
