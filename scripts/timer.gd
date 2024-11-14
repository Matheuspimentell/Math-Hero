extends TextureRect

# Variables
@onready var timer_label = $Label
var current_time: float
var _is_running: bool

func format_time(time: float) -> String:
	var ms = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minutes = time/60
	return "%03d:%02d.%03d" % [minutes, sec ,ms]

func _ready():
	#TODO: Get elapsed time from game manager
	current_time = 0.0
	start()

func _process(delta):
	if _is_running:
		current_time += delta
		timer_label.text = format_time(current_time)

func start() -> void:
	_is_running = true

func stop() -> void:
	_is_running = false

func get_time() -> float:
	return current_time

func set_time(time: float) -> float:
	self.current_time = time
	return self.current_time
