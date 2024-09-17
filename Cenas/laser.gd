extends Area2D


class_name Laser

@export var speed = 600

func _process(delta):
	position.y -= speed * delta
	
func _on_area_entered(area):
	if area is InvaderShot:
		area.queue_free()
		queue_free()
