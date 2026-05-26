extends Node


@export var platform_scenes: Array[PackedScene]
@onready var platform_island: Platform = $PlatformIsland


const OFFSET_UP: Vector2 = Vector2(2.5, 4.5)
const OFFSET_SIDE: Vector2 = Vector2(1.7, 3.7)


func _enter_tree() -> void:
	SignalHub.new_platform.connect(_on_new_platform)

func free() -> void:
	SignalHub.emit_spawner_loaded(platform_island.position.y)

func get_random_offset(offset_range: Vector2) -> float:
	if randf() < 0.5:
		return randf_range(-offset_range.y, -offset_range.x)
	else:
		return randf_range(offset_range.x, offset_range.y)


func spawn_platform(old_platform_postion: Vector3) -> void:
	if platform_scenes.size() == 0:
		return

	var platform_scene = platform_scenes.pick_random()
	var new_platform: Platform = platform_scene.instantiate()

	var random_y_value: float = randf_range(OFFSET_UP.x, OFFSET_UP.y)
	var random_x_value: float = get_random_offset(OFFSET_SIDE)
	var random_z_value: float = get_random_offset(OFFSET_SIDE)

	new_platform.position = old_platform_postion + Vector3(random_x_value, random_y_value , random_z_value)
	add_child(new_platform)


func _on_new_platform(platform_pos: Vector3) -> void:
	spawn_platform(platform_pos)
