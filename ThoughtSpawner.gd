extends Node2D

var THOUGHT := preload("res://thought.tscn")
var rng := RandomNumberGenerator.new()

func spawn(min_speed, max_speed):
	var thought := THOUGHT.instantiate()
	thought.modulate = thought.modulate.darkened(0.5)
	thought.speed = rng.randf_range(min_speed, max_speed)
	thought.position.x = rng.randf_range(0.0, get_viewport_rect().size.x)
	add_child(thought)

func _ready():
	pass
