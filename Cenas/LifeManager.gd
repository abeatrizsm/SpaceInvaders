extends Node

class_name LifeManager

signal life_lost()
@export var lifes = 3
@onready var player = $"../Camera2D/Player"
var player_scene = preload("res://Cenas/player.tscn")

func _ready():
	(player as Player).player_destroyed.connect(player_lifes)

func player_lifes():
	lifes -= 1
	life_lost.emit(lifes)
	if lifes != 0:
		var player = player_scene.instantiate() as Player
		player.global_position = Vector2(0, 302)
		get_tree().root.add_child(player)
		player.player_destroyed.connect(player_lifes)
		
