extends Node

enum EquationType { SUM, SUBTRACTION, MULTIPLICATION, DIVISION }

enum BasicLevels { 
  one_digit_res, 
  one_digit_unres, 
  two_digit_res, 
  two_digit_unres, 
  three_digit_res, 
  three_digit_unres 
}

enum MultiplicationLevels {
  two_by_one,
  three_by_one,
  two_by_two,
  by_five,
  by_eleven
}

enum DivisionLevels {
  one_digit,
  two_digit,
}

# Variables
var current_equation_type: EquationType
var equation_level: int
var elapsed_time: float
var error_count: int
var match_seed

# Equation Generators
var sumGenerator: SumGenerator

# When the game is launched, reset all singleton variables
func _ready():
  current_equation_type = EquationType.SUM
  equation_level = 0
  elapsed_time = 0.0
  error_count = 0
  match_seed = null