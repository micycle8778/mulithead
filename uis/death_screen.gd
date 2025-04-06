class_name DeathScreen
extends Control

static var screenshot: Texture2D

func _ready() -> void:
	if screenshot != null:
		$TextureRect.texture = screenshot

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
