class_name DeathScreen
extends Control

static var screenshot: Texture2D

@export var pitch_shift := 1.:
	set(v):
		pitch_shift = v

		var idx := AudioServer.get_bus_index(&"Music")
		var effect: AudioEffectPitchShift = AudioServer.get_bus_effect(idx, 0)
		effect.pitch_scale = v

func _ready() -> void:
	if screenshot != null:
		$TextureRect.texture = screenshot

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

func _anim_end() -> void:
	# TODO:
	DJMusicMan.play_start()
	pitch_shift = 1.
