class_name Game extends Node2D

static var instance: Game

@onready var ammo_icon: TextureRect = %AmmoIcon
@onready var ammo_label: Label = %AmmoLabel
@onready var health_label: Label = %HealthLabel

var ammo := 100.:
	set(v):
		ammo = v
		_update_labels()
var health := 50.:
	set(v):
		health = v
		_update_labels()

func _init() -> void:
	instance = self

func _update_labels() -> void:
	ammo_label.text = "%03d" % ammo
	health_label.text = "%02d" % health

func _ready() -> void:
	DJMusicMan.play_full()
	_update_labels()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("suicide") and OS.has_feature("editor"):
		var img := get_tree().current_scene.get_viewport().get_texture().get_image()
		DeathScreen.screenshot = ImageTexture.create_from_image(img)
		get_tree().change_scene_to_file("res://uis/death_screen.tscn")
