extends CharacterBody2D

const rpm := 2
const speed := 75

@onready var death_particles: CPUParticles2D = %DeathParticles
@onready var polygon: Polygon2D = %Polygon2D

func _ready() -> void:
	velocity = speed * Vector2.RIGHT.rotated(
		randf_range(PI / 6, PI / 3)
	)

	velocity.x *= [-1, 1].pick_random()
	velocity.y *= [-1, 1].pick_random()

	polygon.rotation = randf() * TAU

func _process(delta: float) -> void:
	polygon.rotation += rpm * TAU * delta

	var v := velocity
	move_and_slide()
	var col := get_last_slide_collision()
	if get_slide_collision_count() > 0:
		var normal = col.get_normal()
		var d = v.dot(normal)
		velocity = v - (d * normal * 2)

func _on_hurt_box_hit(dir: Vector2) -> void:
	remove_child(death_particles)
	get_parent().add_child(death_particles)

	death_particles.global_position = global_position
	death_particles.rotation = dir.angle()
	death_particles.finished.connect(death_particles.queue_free)
	death_particles.emitting = true

	queue_free()
