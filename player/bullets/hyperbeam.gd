extends CharacterBody2D

var dir: Vector2

func _ready() -> void:
	rotation = dir.angle()

