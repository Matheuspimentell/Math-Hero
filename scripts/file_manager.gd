extends Node

# Time attack saving functions
func save_results(gameplay_data: Dictionary) -> void:
	var stored_data: Array = get_results()
	stored_data.append(gameplay_data)
	var new_data: String = JSON.stringify(stored_data)
	var file: FileAccess = FileAccess.open("user://results.json", FileAccess.WRITE)
	file.store_string(new_data)
	file.close()

func get_results() -> Array:
	var json: JSON = JSON.new()
	var data: Array = []
	# var file: FileAccess = FileAccess.open("user://results.json", FileAccess.WRITE_READ)
	var contents = FileAccess.get_file_as_string("user://results.json")
	var response = json.parse(contents)
	if response == OK:
		if typeof(json.data) == TYPE_ARRAY:
			data = json.data
		else:
			print_debug("invalid json format.")
	else:
		print_debug("Error while parsing json: %s" % [response])
	
	return data