extends Node2D

const fire_wait := 0.1
var clock := 0.

func fire_released() -> void:
	return

func fire_pressed(parent: Node, dir: Vector2) -> void:
	print("fire_pressed")
	if clock > 0.: return

	var bullet := PL.basic_bullet.instantiate()
	bullet.dir = dir
	bullet.rotation = dir.angle()
	parent.add_child(bullet)
	bullet.global_position = global_position + 10 * dir

	clock = fire_wait

func _process(delta: float) -> void:
	clock -= delta
