extends CharacterBody2D

enum State {
	CHASE,
	DODGE,
	REST
}

const speed = 90
const dodge_cooldown = 1.
const rest_duration = .4

@onready var death_particles: DeathParticles = %DeathParticles
@onready var player = World.get_instance(self).player
@onready var bullet_detector = %BulletDetector

var state := State.CHASE

var dodge_clock: float
var target_bullet: Node2D
var dodge_direction: Vector2

var rest_clock: float

func _process_dodge(_delta: float) -> void:
	rotation = dodge_direction.angle() + PI

	velocity = dodge_direction * speed * 2.
	move_and_slide()

	var should_rest = is_instance_valid(target_bullet) and \
			target_bullet.global_position.distance_to(global_position) < 82
	
	state = State.REST if should_rest else State.DODGE
	rest_clock = rest_duration

func _process_chase(delta: float) -> void:
	dodge_clock -= delta

	var to_player_hat = global_position.direction_to(player.global_position)
	var dir = Vector2.RIGHT.rotated(rotation)
	dir = dir.slerp(to_player_hat, .15)

	rotation = dir.angle()
	velocity = dir * speed

	move_and_slide()

func _process_rest(delta: float) -> void:
	rest_clock -= delta
	if rest_clock < 0.:
		state = State.CHASE
	
	velocity = velocity.lerp(Vector2.ZERO, .04)
	move_and_slide()

func should_dodge() -> bool:
	if dodge_clock > 0.: return false
	if bullet_detector.get_overlapping_bodies().is_empty(): return false

	# setup
	dodge_clock = dodge_cooldown
	target_bullet = bullet_detector.get_overlapping_bodies()[0]

	var dir = target_bullet.dir if "dir" in target_bullet \
			else target_bullet.global_position.direction_to(global_position)
	var v = dir.rotated(PI / 2)
	if v.dot(velocity) < 0:
		dodge_direction = v
	else:
		dodge_direction = -v

	return true

func _physics_process(delta: float) -> void:
	match state:
		State.CHASE:
			_process_chase(delta)
			state = State.DODGE if should_dodge() else State.CHASE
		State.DODGE:
			_process_dodge(delta)
		State.REST:
			_process_rest(delta)

func _on_hurt_box_hit(dir: Vector2) -> void:
	Game.instance.score += 3
	death_particles.emit(get_parent(), dir)
	queue_free()
