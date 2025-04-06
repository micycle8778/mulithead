extends CharacterBody2D

const rpm := 2
const speed := 75

@onready var death_particles: DeathParticles = %DeathParticles
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
	death_particles.emit(get_parent(), dir)
	queue_free()
