extends CharacterBody3D


class_name Player


@onready var fall_sound_effect: AudioStreamPlayer3D = $FallSoundEffect
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var anim_player: AnimationPlayer = $AnimationPlayer


const GRAVITY: float = 62.0#40.0
const JUMP_FORCE: float = 30.0#18.0
const ROTATION_SPEED: float = 4.0
const MOVE_SPEED: float = 3.5
const LAND_BUFFER: float = 1.0
const FALLING_BUFFER: float = -40.0


var _last_landed: float = 0.0
var _start_height: float = 0.0
var _best_height: float = 0.0
var _fall_sound_effect_is_playing: bool = false


func _enter_tree() -> void:
	#SignalHub.new_platform.connect(_play_land_sound_effect)
	SignalHub.spawner_loaded.connect(_on_spawner_loaded)

func _ready() -> void:
	_start_height = position.y
	await get_tree().process_frame
	SignalHub.emit_new_height(_best_height)


func _physics_process(delta: float) -> void:
	handle_rotation(delta)
	handle_gravity(delta)
	handle_movement()
	move_and_slide()
	handle_animation()
	update_best_height()


func handle_rotation(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		rotate_y(ROTATION_SPEED * delta)
	elif Input.is_action_pressed("ui_right"):
		rotate_y(-ROTATION_SPEED * delta)


func handle_movement() -> void:
	var dir: Vector3 = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		dir = transform.basis.z
	velocity.x = dir.x * MOVE_SPEED
	velocity.z = dir.z * MOVE_SPEED


func handle_gravity(delta: float) -> void:
	if is_on_floor():
		velocity.y = JUMP_FORCE
		if position.y > _last_landed:
			audio_stream_player_3d.play()
			_last_landed = position.y + LAND_BUFFER
	else:
		velocity.y -= GRAVITY * delta


func handle_animation() -> void:
	if velocity.y > 0:
		anim_player.play("jump")
	else:
		anim_player.play("fall")
		#if velocity.y < FALLING_BUFFER and !fall_sound_effect_is_playing:
			#fall_sound_effect.play()
			#fall_sound_effect_is_playing = true
		if position.y < _last_landed - 5.0 and !_fall_sound_effect_is_playing:
			fall_sound_effect.play()
			_fall_sound_effect_is_playing = true


func _on_spawner_loaded(y_position: float) -> void:
	_last_landed = y_position - LAND_BUFFER * 2


func update_best_height() -> void:
	if position.y - _start_height > _best_height:
		_best_height = position.y - _start_height
		SignalHub.emit_new_height(_best_height)
		print(_best_height)


#func _play_land_sound_effect(_position: Vector3) -> void:
	#audio_stream_player_3d.play()
