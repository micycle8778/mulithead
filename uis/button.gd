extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
	pass

func _ready() -> void:
	pressed.connect(_on_pressed)
