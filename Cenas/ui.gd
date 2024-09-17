extends CanvasLayer

@onready var points_label = $MarginContainer/PointsLabel
@onready var lifes_container = $MarginContainer/LifesContainer
@onready var game_over_container = $MarginContainer/GameOverContainer
@onready var game_over_label = $MarginContainer/GameOverContainer/VBoxContainer/GameOverLabel
@onready var game_over_button = $MarginContainer/GameOverContainer/VBoxContainer/GameOverButton

@onready var invader_spawner = $"../Invader Spawner" as InvaderSpawner
@onready var life_manager = $"../LifeManager" as LifeManager
@onready var points_counter = $"../PointsCounter" as PointsCounter
@onready var trilha_sonora = $trilha_sonora
@onready var game_over_sound = %gameOverSound
@onready var animation_player = $MarginContainer/PowerUp/AnimationPlayer

var life_texture = preload("res://CustomAssets/AssetsNovos/Heart/Coração1.PNG")

func _ready():
	animation_player.play("countdown")
	points_label.text = "SCORE: %d" %0
	points_counter.increased_points.connect(on_points)
	life_manager.life_lost.connect(on_life_lost)
	invader_spawner.game_lost.connect(on_game_lost)
	invader_spawner.game_won.connect(on_game_won)
	trilha_sonora.play()
	
	for i in range(life_manager.lifes):
		var life_texture_rect = TextureRect.new()
		life_texture_rect.texture = life_texture
		life_texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		life_texture_rect.custom_minimum_size = Vector2(40, 40)
		life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		lifes_container.add_child(life_texture_rect)

func on_points(points: int):
	points_label.text = "SCORE: %d" %points
	
func on_life_lost(lifes: int):
	var life_texture_rect = lifes_container.get_child(lifes)
	if lifes != 0:
		life_texture_rect.queue_free()
	else:
		life_texture_rect.queue_free()
		on_game_lost()
		
func on_game_lost():
	game_over_container.visible = true
	trilha_sonora.stop()
	game_over_sound.play()
	
func on_game_won():
	game_over_container.visible = true
	game_over_label.text = "You Won!"
	game_over_label.add_theme_color_override("font_outline_color", Color.MEDIUM_SPRING_GREEN)

func _on_game_over_button_pressed():
	get_tree().reload_current_scene()
