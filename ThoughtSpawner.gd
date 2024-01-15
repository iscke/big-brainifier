extends Node2D

var THOUGHT := preload("res://thought.tscn")
var rng := RandomNumberGenerator.new()

func spawn(min_speed, max_speed, fast_min, fast_max, fast_chance):
	var thought := THOUGHT.instantiate()

	if rng.randf() < fast_chance:
		thought.speed = rng.randf_range(fast_min, fast_max)
		thought.modulate = Color.DARK_RED
	else:
		thought.speed = rng.randf_range(min_speed, max_speed)
		thought.modulate = thought.modulate.darkened(0.5)
	thought.position.x = rng.randf_range(0.0, get_viewport_rect().size.x)
	add_child(thought)

func _ready():
	pass
