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

func _init() -> void:
	instances = instances.filter(is_instance_valid)
	instances.push_back(self)
