extends Control

const leaderboard = "res://scenes/leaderboard.tscn"

@onready var elapsed_time = $MarginContainer/background/MarginContainer/info/time/elapsed_time
@onready var errors = $MarginContainer/background/MarginContainer/info/errors/error_counter
@onready var penalties = $MarginContainer/background/MarginContainer/info/penalties/penalty_counter
@onready var final_time_label = $MarginContainer/background/MarginContainer/info/final_time/total_time
@onready var name_dialog = $MarginContainer/background/name_dialog
@onready var player_name = $MarginContainer/background/name_dialog/VBoxContainer/LineEdit

func _ready():
	# Get all data from GameManager and perform calculations
	SfxManager.play("upbeat_background")
	elapsed_time.text = format_time(GameManager.tattack_results["time"]) if GameManager.tattack_results.has("time") else "000:00.000"
	errors.text = "%d" % [GameManager.tattack_results["errors"]] if GameManager.tattack_results.has("errors") else "0"
	penalties.text = "+%d s" % [self.get_total_penalty_time()]
	final_time_label.text = calculate_final_time()

func _input(event):
	# If accept is pressed, show popup to input name
	if event.is_action_released("accept"):
		SfxManager.play("accept")
		name_dialog.visible = true
		player_name.grab_focus()

func get_total_penalty_time() -> float:
	var total_penalty_time = 0
	if GameManager.tattack_results.has("errors"):
		total_penalty_time += GameManager.tattack_results.get("errors")*30
	total_penalty_time += GameManager.skip_count*300
	return total_penalty_time

func format_time(time: float) -> String:
	var ms = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minutes = time/60
	return "%03d:%02d.%03d" % [minutes, sec ,ms]

func calculate_final_time() -> String:
	var time: float = GameManager.tattack_results["time"] if GameManager.tattack_results.has("time") else 0
	var penalty_time: float = get_total_penalty_time()
	var final_time = format_time(time+penalty_time)
	GameManager.skip_count = 0 # Reset skip counter
	return final_time

func _on_name_submitted(new_text:String):
	# Add result to time attack results json
	GameManager.tattack_results["user"] = new_text
	GameManager.tattack_results["time"] = calculate_final_time()
	GameManager.tattack_results["date"] = Time.get_datetime_string_from_system(true,true)
	# Change scene to leaderboard and save current results
	FileManager.save_results(GameManager.tattack_results)
	GameManager.change_scene(leaderboard)

func _on_text_changed(new_text: String):
	var allowed_characters = "[A-Za-z0-9]"
	var old_caret_position = player_name.caret_column
	var word = ""
	var regex = RegEx.new()
	regex.compile(allowed_characters)
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
		player_name.set_text(word)
	player_name.caret_column = old_caret_position
