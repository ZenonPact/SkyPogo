extends Node


signal new_platform(platform_pos: Vector3)
signal spawner_loaded(y_position: float)
signal update_new_height(height: float)
signal game_over


func game_over_emit() -> void:
	game_over.emit()


func emit_new_platform(platform_pos: Vector3) -> void:
	new_platform.emit(platform_pos)


func emit_spawner_loaded(y_position: float) -> void:
	spawner_loaded.emit(y_position)


func emit_new_height(height: float) -> void:
	update_new_height.emit(height)
	
