class_name DeathParticles
extends CPUParticles2D

func emit(parent: Node, dir: Vector2) -> void:
	var gp = global_position

	get_parent().remove_child(self)
	parent.add_child(self)

	global_position = gp
	rotation = dir.angle()
	finished.connect(queue_free)
	emitting = true
