extends Control

@onready var elapsed_time = $MarginContainer/background/MarginContainer/info/time/elapsed_time
@onready var errors = $MarginContainer/background/MarginContainer/info/errors/error_counter
@onready var penalties = $MarginContainer/background/MarginContainer/info/penalties/penalty_counter
@onready var final_time_label = $MarginContainer/background/MarginContainer/info/final_time/total_time
@onready var name_dialog = $MarginContainer/background/name_dialog
@onready var player_name = $MarginContainer/background/name_dialog/VBoxContainer/LineEdit

func _ready():
	# Get all data from GameManager and perform calculations
	elapsed_time.text = format_time(GameManager.tattack_results["time"]) if GameManager.tattack_results.has("time") else "000:00.000"
	errors.text = "%d" % [GameManager.tattack_results["errors"]] if GameManager.tattack_results.has("errors") else "0"
	penalties.text = "+%d s" % [self.get_total_penalty_time()]
	final_time_label.text = get_final_time()

func _input(event):
	# If accept is pressed, show popup to input name
	if event.is_action_released("accept"):
		name_dialog.visible = true
		player_name.grab_focus()

func get_total_penalty_time() -> float:
	return GameManager.tattack_results["errors"] * 30 if GameManager.tattack_results.has("errors") else 0

func format_time(time: float) -> String:
	var ms = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minutes = fmod(time, 3600) / 60
	return "%03d:%02d.%03d" % [minutes, sec ,ms]

func get_final_time() -> String:
	var time: float = GameManager.tattack_results["time"] if GameManager.tattack_results.has("time") else 0
	var penalty_time: float = get_total_penalty_time()
	var final_time = format_time(time+penalty_time)
	return final_time

func _on_name_submitted(new_text:String):
	# Change scene to leaderboard
