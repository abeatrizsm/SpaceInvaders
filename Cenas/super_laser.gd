extends Area2D

class_name SuperLaser

@export var speed = 900

func _process(delta):
	position.y -= speed*delta
