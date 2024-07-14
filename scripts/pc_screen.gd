extends Control

@onready var _error_label = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/error_counter/Label
@onready var _answer_label = $MarginContainer/MarginContainer/VBoxContainer/answer/Label
@onready var _seed_label = $MarginContainer/MarginContainer/VBoxContainer/tooltips/seed
@onready var _question_label = $MarginContainer/MarginContainer/VBoxContainer/question/Label

var errors: int = 0

func _ready():
	_answer_label.text = ""
	_seed_label.text = "abc"
	_question_label.text = "7 + 10 = ?"

func add_error() -> void:
	errors+=1
	_error_label.text = "x%d" % errors
