extends Control

enum NUMPADKEYS  {
	number0,
	number1,
	number2,
	number3,
	number4,
	number5,
	number6,
	number7,
	number8,
	number9,
	backspace,
	change_sign
}

@onready var _error_label = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/error_counter/Label
@onready var _error_counter = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/error_counter
@onready var _timer = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/timer
@onready var _answer_label = $MarginContainer/MarginContainer/VBoxContainer/answer/Label
@onready var _seed_label = $MarginContainer/MarginContainer/VBoxContainer/tooltips/seed
@onready var _question_label = $MarginContainer/MarginContainer/VBoxContainer/question/Label
@onready var _numpad = $MarginContainer/MarginContainer/VBoxContainer/CenterContainer2/numpad

var errors: int = 0

func _ready():
	for key in _numpad.get_children():
		key.clicked.connect(_on_numpad_clicked)
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
	set_answer_text("")
	set_question_text("")

func add_error() -> void:
	errors+=1
	_error_label.text = "x%d" % errors

func set_question_text(new_text: String) -> void:
	_question_label.text = new_text

func set_seed_text() -> void:
	if GameManager.tattack_options.has("seed"):
		_seed_label.text = "%d" % GameManager.tattack_options["seed"]
	else:
		_seed_label.text = "null"

func set_answer_text(new_text: String) -> void:
	_answer_label.text = new_text

func _on_numpad_clicked(buttonName):
	var button = NUMPADKEYS[buttonName]

	if button == NUMPADKEYS.backspace:
		if _answer_label.text.is_empty():
			print_debug("Label is empty")
			# sfx_manager.play_sound("error")
			return
		else:
			_answer_label.text = _answer_label.text.erase(_answer_label.text.length()-1)
	elif button == NUMPADKEYS.change_sign:
		if not _answer_label.text.is_empty() and _answer_label.text[0] == "-":
			_answer_label.text = _answer_label.text.erase(0)
		else:
			_answer_label.text = "-" + _answer_label.text
	else:
		_answer_label.text+=str(button)

	# sfx_manager.play_sound("click")
