class_name WormSegment
extends CharacterBody2D

const speed = 60

@onready var death_particles: DeathParticles = %DeathParticles
@onready var player := World.get_instance(self).player

func _head_process(_delta: float) -> void:
	%BodyVisual.visible = false
	%HeadVisual.visible = true

	var dir := Vector2.RIGHT.rotated(rotation)
	dir = dir.slerp(global_position.direction_to(player.global_position), .4)

	rotation = dir.angle()
	velocity = dir * speed
	move_and_slide()

func _body_process(_delta: float, prev_segment: WormSegment) -> void:
	%BodyVisual.visible = true
	%HeadVisual.visible = false

	look_at(prev_segment.global_position)
	var v := global_position - prev_segment.global_position
	v = v.normalized() * 7
	global_position = prev_segment.global_position + v

func _on_hurt_box_hit(dir: Vector2) -> void:
	death_particles.emit(get_parent(), dir)
	queue_free()
