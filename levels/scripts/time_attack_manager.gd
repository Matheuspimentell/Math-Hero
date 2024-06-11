extends Node

enum EquationType { SUM, SUBTRACTION, MULTIPLICATION, DIVISION }

# Singleton variables
var error_count: int
var match_seed
var time_elapsed: float
var current_equation_type: EquationType

#TODO: Add current difficulty tracking stats

# Signals
signal on_change_equation_type
