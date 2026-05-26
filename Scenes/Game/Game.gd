extends Node

func _ready() -> void:
	get_tree().paused = false

func _on_floor_body_entered(body: Node3D) -> void:
	if body is Player :
		#get_tree().reload_current_scene()
		SignalHub.game_over_emit()
		get_tree().paused = true
