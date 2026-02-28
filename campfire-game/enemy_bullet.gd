extends Area2D

@export var speed := 250
var direction := Vector2.ZERO

func _process(delta):
	position += direction * speed * delta
