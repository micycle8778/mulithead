class_name Wave 
extends Resource

@export var enemies: Array[EnemySpawn]
@export var duration: float
@export var spawn_count: float
@export var wait_time: float

func pick_random_enemy() -> PackedScene:
	var sum: float = enemies.reduce(
		func(acc, e): return acc + e.weight,
		0.
	)
	var random := sum * randf()
	for e in enemies:
		random -= e.weight
		if random < 0.:
			return e.scene
	return enemies[-1].scene

func execute(spawner: EnemySpawner) -> void:
	for i in int(spawn_count):
		var sample := randf() * (spawner.curve.point_count - 1)
		var pos := spawner.curve.samplef(sample)
		var enemy = pick_random_enemy().instantiate()
		enemy.position = pos
		spawner.add_sibling(enemy)

		await PL.get_tree().create_timer(duration / spawn_count, false).timeout
		if not is_instance_valid(spawner): return

	await PL.get_tree().create_timer(wait_time, false).timeout
