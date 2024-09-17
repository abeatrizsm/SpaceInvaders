extends Node2D

@onready var sound_shoot = $soundShoot
@onready var sound_superShot = $soundSuperShoot
var laser_scene = preload("res://Cenas/lazer.tscn")
var superTiro_scene = preload("res://Cenas/super_laser.tscn") 
var can_player_shoot = true
var can_player_supershot = false

func _ready():
	$countdown.wait_time = 10.0
	$countdown.one_shot = true
	
	$super_shot_timer.wait_time = 2.0
	$super_shot_timer.one_shot = true
	
	
	$countdown.start()

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		if can_player_supershot:
			var supertiro = superTiro_scene.instantiate() as SuperLaser
			supertiro.global_position = get_parent().global_position - Vector2(0, 20)
			get_tree().root.add_child(supertiro)
			sound_superShot.play()
		elif can_player_shoot:
			var laser = laser_scene.instantiate() as Laser
			laser.global_position = get_parent().global_position - Vector2(0, 20)
			get_tree().root.add_child(laser)
			can_player_shoot = false
			laser.tree_exited.connect(_tree_exited)
			sound_shoot.play()
	
func _tree_exited():
	can_player_shoot = true
	
	
func _on_countdown_timeout():
	can_player_supershot = true
	can_player_shoot = false
	$super_shot_timer.start()
	
func _on_super_shot_timer_timeout():
	can_player_supershot = false
	can_player_shoot = true
	$countdown.start()
