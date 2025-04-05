class_name MainCam 
extends Camera2D

static var instances: Array[MainCam]

static func shake(amount: float) -> void:
	for instance in instances:
		instance.shake_duration += amount

@export var player: Player
var shake_duration := 0.
@onready var noise := FastNoiseLite.new()

func _init() -> void:
	instances = instances.filter(is_instance_valid)
	instances.push_back(self)

func _ready() -> void:
	noise.frequency = 1000

func _process(delta: float) -> void:
	global_position = player.global_position

	shake_duration = move_toward(shake_duration, 0, delta)
	if shake_duration > 0.:
		offset = Vector2(
			noise.get_noise_1d(shake_duration),
			noise.get_noise_1d(-shake_duration)
		) * 5

	else:
		offset = Vector2.ZERO
