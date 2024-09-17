extends CanvasLayer

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _ready():
	audio_stream_player_2d.play()
	
func _load_game():
	get_tree().change_scene_to_file("res://Cenas/points_screen.tscn")


