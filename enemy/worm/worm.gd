extends Node2D

func get_segments() -> Array[WormSegment]:
	var ret: Array[WormSegment]
	ret.assign(get_children().filter(func(c): return c is WormSegment))
	return ret

func _process(delta: float) -> void:
	var segments := get_segments()

	if get_segments().is_empty():
		Game.instance.score += 5
		queue_free()

	var is_head := true
	for idx in range(segments.size() - 1, -1, -1):
		var segment := segments[idx]

		if is_head:
			segment._head_process(delta)
		else:
			segment._body_process(delta, segments[idx + 1])

		is_head = false
