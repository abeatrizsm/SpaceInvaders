extends Node2D

var ufo_scene: PackedScene = preload("res://Cenas/ufo.tscn")
@onready var spawn_timer = $SpawnTimer

func _ready():
	(spawn_timer as SpawnTimer).setup_timer()
	
func _on_spawn_timer_timeout():
	var ufo = ufo_scene.instantiate() as Ufo
	ufo.global_position = position
	get_tree().root.add_child(ufo)
	(spawn_timer as SpawnTimer).setup_timer()
