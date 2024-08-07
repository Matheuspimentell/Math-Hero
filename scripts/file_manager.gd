extends Node

# Time attack saving functions
func save_results(gameplay_data: Dictionary) -> void:
	var data: String = JSON.stringify(gameplay_data) + ","
	var file: FileAccess = FileAccess.open("user://time_attack_results.json", FileAccess.WRITE_READ)
	file.store_line(data)
	file.close()