extends Area2D

static var count := 0

const weapons: Array[StringName] = [
	&"Basic",
	&"Shotgun",
	&"Hyperbeam",
	&"Bomb"
]

const weapon_to_texture: Dictionary[StringName, Texture2D] = {
	&"Basic": PL.basic_weapon_texture,
	&"Shotgun": PL.shotgun_weapon_texture,
	&"Hyperbeam": PL.hyperbeam_weapon_texture,
	&"Bomb": PL.bomb_weapon_texture,
}

@onready var ammo_icon: Sprite2D = %AmmoIcon
@onready var contained_weapon: StringName = weapons.pick_random()

func _ready() -> void:
	count += 1

	if count > 3:
		queue_free()

	ammo_icon.texture = weapon_to_texture[contained_weapon]

func _exit_tree() -> void:
	count -= 1

func _on_body_entered(body: Node2D) -> void:
	for w in World.instances:
		w.player.current_weapon = contained_weapon

	queue_free()
