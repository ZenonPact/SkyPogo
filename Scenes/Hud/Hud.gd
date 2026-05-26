extends Control


@onready var score: Label = $MarginContainer/Score
@onready var best: Label = $MarginContainer/Best
@onready var color_rect: ColorRect = $ColorRect
@onready var game_over_label: Label = $ColorRect/GameOverLabel



var _hsr: HighScoreResource = HighScoreResource.load_or_create()
var _current_score: int = 0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()


func _enter_tree() -> void:
	SignalHub.update_new_height.connect(update_score)
	SignalHub.game_over.connect(game_over)


func _ready() -> void:
	best.text = "Best: %05d" % _hsr.high_score


func game_over() -> void: 
	color_rect.show()
	if _hsr.check_and_update(_current_score) == true:
		game_over_label.text = "Just testing!"


func update_score(height: float) -> void:
	_current_score = int(height)
	score.text = "%05d" % _current_score
