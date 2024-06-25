extends Node

enum TimeAttackModes { NORMAL, COMPETITION, PRACTICE }

enum EquationType { SUM, SUBTRACTION, MULTIPLICATION, DIVISION }

enum SumLevels { 
  one_digit_res, 
  one_digit_unres, 
  two_digit_res, 
  two_digit_unres, 
  three_digit_res, 
  three_digit_unres 
}

enum SubLevels {
  two_digit_res,
  two_digit_unres,
  three_digit_res,
  three_digit_unres,
  four_on_three_digit
}

enum MultiplicationLevels {
  by_five,
  by_eleven,
  two_by_one,
  three_by_one,
  two_by_two
}

enum DivisionLevels {
  two_by_one,
  three_by_one,
  four_by_one,
  three_by_two,
  four_by_two
}

# Variables
var t_attack_mode: TimeAttackModes
var current_equation_type: EquationType
var equation_level: int
var _max_level: int
var elapsed_time: float
var error_count: int
var match_seed

# Equation Generators
var sumGenerator: SumGenerator

# Signals
signal time_attack_finished

# Set the default variable values
func _ready():
  current_equation_type = EquationType.SUM
  _max_level = SumLevels.size()-1
  equation_level = 0
  elapsed_time = 0.0
  error_count = 0
  match_seed = null
  t_attack_mode = TimeAttackModes.COMPETITION

func _change_equation_type():
  if current_equation_type >= EquationType.size():
    pass
  match t_attack_mode as TimeAttackModes:
    TimeAttackModes.COMPETITION:
      current_equation_type += (1 as EquationType)
      match current_equation_type:
        EquationType.MULTIPLICATION:
          _max_level = MultiplicationLevels.size()-1
        EquationType.DIVISION:
          _max_level = DivisionLevels.size()-1
        EquationType.SUM:
          _max_level = SumLevels.size()-1
        EquationType.SUBTRACTION:
          _max_level = SubLevels.size()-1
        _:
          _max_level = -1
          print_debug("Not known equation type! Max Level: %d" % _max_level)
          get_tree().quit()

      equation_level = 0
    TimeAttackModes.PRACTICE:
      pass
    _:
      get_tree().quit()
      pass

func increase_equation_level():
  if equation_level >= _max_level:
    _change_equation_type()
  
  equation_level+=1