class_name MainCam 
extends Camera2D

@export var player: Player
var shake_duration := 0.
var shake_intensity := 1.
@onready var noise := FastNoiseLite.new()

func shake(amount: float, intensity := 1.) -> void:
	shake_duration = maxf(shake_duration, amount)
	shake_intensity = maxf(shake_intensity, intensity)


func _ready() -> void:
	noise.frequency = 1000

func _process(delta: float) -> void:
	global_position = player.global_position

	shake_duration = move_toward(shake_duration, 0, delta)
	if shake_duration > 0.:
		offset = Vector2(
			noise.get_noise_1d(shake_duration),
			noise.get_noise_1d(-shake_duration)
		) * 5 * shake_intensity

	else:
		offset = Vector2.ZERO
