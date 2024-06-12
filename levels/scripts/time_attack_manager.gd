extends Node

enum EquationType { SUM, SUBTRACTION, MULTIPLICATION, DIVISION }

# Variables
var error_count: int
var match_seed
var elapsed_time: float
var current_equation_type: EquationType
var equation_level: int

#TODO: Add current difficulty tracking stats
