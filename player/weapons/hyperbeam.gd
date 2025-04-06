extends Node2D

@export var speed_curve: Curve
@onready var circle: TextureProgressBar = $Circle

const max_charge = .35
var charge := 0.:
	set(v):
		charge = v
		circle.value = inverse_lerp(0., max_charge, v)

var clock := 0.

var has_fired := false

func equipped() -> void:
	Game.instance.ammo = 175
	Game.instance.ammo_icon.texture = PL.hyperbeam_weapon_texture

func _update_player_speed() -> void:
	World.get_instance(self).player.speed_mul = speed_curve.sample(clock)

func fire_released(delta: float) -> void:
	charge = move_toward(charge, 0., delta)
	has_fired = false
	
	clock = move_toward(clock, 0., delta)
	_update_player_speed()

func fire_pressed(delta: float, parent: Node, dir: Vector2) -> void:
	if Game.instance.ammo <= 0: return fire_released(delta)

	if has_fired: 
		clock = move_toward(clock, 0., delta)
		_update_player_speed()
		return
	_update_player_speed()

	charge = move_toward(charge, max_charge, delta)
	clock = move_toward(clock, speed_curve.max_domain, delta)

	if World.has_prio(self): Game.instance.ammo -= delta * 40
	if charge < max_charge: return

	charge = 0.
	has_fired = true

	MainCam.shake(.1)

	var bullet := PL.hyperbeam_bullet.instantiate()
	bullet.dir = dir
	parent.add_child(bullet)
	bullet.global_position = global_position + 10 * dir
