extends Area2D
class_name InvaderShot

var speed = 200

func _process(delta):
	position.y += speed * delta

func _on_area_entered(area):
	if area is Player:
		(area as Player).on_player_destroyed()
		queue_free()
	if area is Laser:
		area.queue_free()
		queue_free()
	if area is SuperLaser:
		area.queue_free()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
