class_name World extends Node2D

static var instances: Array[World]

static func get_instance(node: Node) -> World:
	for w in instances:
		if w.is_ancestor_of(node):
			return w
	
	return null

static func has_prio(node: Node) -> bool:
	return get_instance(node) == instances[-1]

@export var player: Player
@export var main_cam: MainCam

func _init() -> void:
	instances = instances.filter(is_instance_valid)
	instances.push_back(self)

func _ready() -> void:
	%PickupSpawnTimer.wait_time = randf_range(9., 12.)
	%PickupSpawnTimer.start()

func _on_pickup_spawn_timer_timeout() -> void:
	var pickup := PL.ammo_pickup.instantiate()
	pickup.position = Vector2(
		randf_range(-128, 128),
		randf_range(-128, 128)
	)

	add_child(pickup)
