class_name Player
extends CharacterBody2D

const MAX_SPEED = 130
const ACCEL = 1125

var speed_mul := 1.
@onready var aim_hint: Line2D = %AimHint

var _weapon_node: Node
@onready var current_weapon := "Bomb":
	set(v):
		current_weapon = v
		if (not is_node_ready()): return
		_weapon_node = %Weapons.get_node_or_null(v)
		_weapon_node.equipped()

func _ready() -> void:
	_weapon_node = %Weapons.get_node_or_null(current_weapon)
	_weapon_node.equipped.call_deferred()

func _process(_delta: float) -> void:
	var aim = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	aim = aim.normalized()

	# aim_hint.visible = not aim.is_zero_approx()
	# aim_hint.global_rotation = aim.angle()

	if _weapon_node == null: return
	if aim.is_zero_approx():
		_weapon_node.fire_released()
	else:
		_weapon_node.fire_pressed(get_parent(), aim)

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_velocity = input * MAX_SPEED * speed_mul

	velocity = velocity.move_toward(
		desired_velocity, 
		ACCEL * delta
	)

	move_and_slide()

	var dir := Vector2.RIGHT.rotated(rotation)
	var v := dir.slerp(input.normalized(), .5)
	rotation = v.angle()

func _on_hurt_box_body_entered(body: Node2D) -> void:
	# TODO: detect player death
	Game.instance.health -= 10
	MainCam.shake(.2)
	body.queue_free()
