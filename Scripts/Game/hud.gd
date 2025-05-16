extends CanvasLayer

var score :=0

func update_score(value:int):
	score +=value
	$ScoreLabel.text = "Score:"+str(score)
	
func _ready() -> void:
	var btn = $GameOver/VBoxContainer/NewGame
	btn.connect("pressed",Callable(self,"on_pressed").bind(btn.name))
	btn = $GameOver/VBoxContainer/Quit
	btn.connect("pressed",Callable(self,"on_pressed").bind(btn.name))


func _on_game_game_over() -> void:
	#var gameover_label = Label.new()
	#gameover_label.text = "Game Over"
	#gameover_label.add_theme_font_size_override("font_size",30)
	#add_child(gameover_label)
	$GameOver.visible = true

func on_pressed(btn:StringName):
	if btn == "NewGame":
		get_tree().reload_current_scene()
	if btn == "Quit":
		get_tree().change_scene_to_file("res://Level/Main.tscn")
