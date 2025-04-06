class_name EnemySpawner
extends Path2D

@export var waves: Array[Wave]


func _ready() -> void:
	for wave in waves:
		await wave.execute(self)
	
	var final_wave: Wave = waves[-1].duplicate()
	while true:
		final_wave.spawn_count *= 1.15
		await final_wave.execute(self)
