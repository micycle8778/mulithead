extends Area2D

signal hit(dir: Vector2)

func _on_body_entered(body: Node2D):
	var dir: Vector2 = \
		body.dir if "dir" in body \
		else body.global_position.direction_to(global_position)
	
	hit.emit(dir)
