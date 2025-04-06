extends Node2D

const fire_wait := 1.
var clock := 0.

func equipped() -> void:
	Game.instance.ammo = 20
	Game.instance.ammo_icon.texture = PL.bomb_weapon_texture

func fire_released() -> void:
	return

func fire_pressed(parent: Node, dir: Vector2) -> void:
	if clock > 0.: return
	if Game.instance.ammo <= 0: return

	var bullet := PL.bomb.instantiate()
	bullet.dir = dir
	bullet.rotation = dir.angle()
	parent.add_child(bullet)
	bullet.global_position = global_position + 10 * dir

	clock = fire_wait
	if World.has_prio(self): Game.instance.ammo -= 1

func _process(delta: float) -> void:
	clock -= delta
