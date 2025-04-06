extends Node2D

const fire_wait := 0.1
var clock := 0.

func equipped() -> void:
	Game.instance.ammo = 150
	Game.instance.ammo_icon.texture = PL.shotgun_weapon_texture

func fire_released(_delta: float) -> void:
	return

func fire_pressed(_delta: float, parent: Node, dir: Vector2) -> void:
	print("fire_pressed")
	if clock > 0.: return
	if Game.instance.ammo <= 0: return

	for angle in [-PI / 6, 0, PI / 6]:
		var bullet := PL.basic_bullet.instantiate()
		var v := dir.rotated(angle)
		bullet.dir = v
		bullet.rotation = v.angle()
		parent.add_child(bullet)
		bullet.global_position = global_position + 10 * v

	clock = fire_wait
	if World.has_prio(self): Game.instance.ammo -= 1

func _process(delta: float) -> void:
	clock -= delta
