extends Node3D


class_name  Platform


#signal new_platform(platform_pos: Vector3)

const WAIT_TIME: float = 5.0
const WAIT_TIME_VAR: float = 1.5


@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var player_detector: Area3D = $PlayerDetector



func _ready() -> void:
	timer.wait_time = WAIT_TIME
	timer.wait_time += randf_range(-WAIT_TIME_VAR, WAIT_TIME_VAR)


func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	anim_player.play("vanish")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()


func _on_player_detector_body_entered(body: Node3D) -> void:
	if body is Player:
		player_detector.body_entered.disconnect(_on_player_detector_body_entered)
		timer.start()
		SignalHub.emit_new_platform(position)
		#new_platform.emit(position)
