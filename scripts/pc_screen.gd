extends Control

@onready var _error_label = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/error_counter/Label
@onready var _error_counter = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/error_counter
@onready var _timer = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/timer
@onready var _answer_label = $MarginContainer/MarginContainer/VBoxContainer/answer/Label
@onready var _seed_label = $MarginContainer/MarginContainer/VBoxContainer/tooltips/seed
@onready var _question_label = $MarginContainer/MarginContainer/VBoxContainer/question/Label

var errors: int = 0

func _ready():
	if GameManager.game_mode as GameManager.Game_Modes == GameManager.Game_Modes.TimeAttack:
		set_time_attack()
	else:
		set_story()

func set_time_attack() -> void:
	set_answer_text("")
	set_seed_text()
	set_question_text("")
	

func set_story() -> void:
	_seed_label.visible = false
	_error_counter.visible = false
	_timer.visible = false

func add_error() -> void:
	errors+=1
	_error_label.text = "x%d" % errors

func set_question_text(new_text: String) -> void:
	_question_label.text = new_text

func set_seed_text() -> void:
	if GameManager.tattack_options.has("seed"):
		_seed_label.text = GameManager.tattack_options["seed"]
	else:
		_seed_label.text = "null"

func set_answer_text(new_text: String) -> void:
	_answer_label.text = new_text