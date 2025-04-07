extends Label

func _ready() -> void:
	text = "SCORE: %d" % Game.readonly_score
