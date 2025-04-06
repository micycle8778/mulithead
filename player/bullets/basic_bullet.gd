extends CharacterBody2D

const speed := 300.
var dir: Vector2

func hit_enemy():
	queue_free()

func _ready() -> void:
	velocity = dir * speed

func _process(_delta: float) -> void:
	move_and_slide()
	if get_slide_collision_count() > 0:
		queue_free()
