extends CharacterBody2D

const initial_speed := 200.
var clock := .65
var dir: Vector2

func _ready() -> void:
	velocity = dir * initial_speed

	await get_tree().create_timer(clock, false).timeout
	var explosion = PL.explosion.instantiate()
	explosion.position = position
	add_sibling(explosion)
	MainCam.shake(.1)
	queue_free()

func _physics_process(_delta: float) -> void:
	velocity = velocity.lerp(Vector2.ZERO, .05)
	move_and_slide()
