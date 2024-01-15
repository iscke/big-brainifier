extends Node2D

var speed : float

func _ready() -> void:
	add_to_group("thoughts")

func _process(delta: float) -> void:
	position.y -= speed * delta
