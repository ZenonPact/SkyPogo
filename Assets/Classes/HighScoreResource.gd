extends Resource


class_name  HighScoreResource


@export var high_score: int = 0


const SCORES_PATH: String = "user://skypogo.tres"


static func load_or_create() -> HighScoreResource:
	var hsr: HighScoreResource = null
	if ResourceLoader.exists(SCORES_PATH):
		hsr = load(SCORES_PATH)
		if hsr: return hsr
	hsr = HighScoreResource.new()
	hsr.save()
	return hsr


func save() -> void:
	ResourceSaver.save(self, SCORES_PATH)


func check_and_update(score: int) -> bool:
	if score > high_score:
		high_score = score
		save()
		return true
	return false
	
