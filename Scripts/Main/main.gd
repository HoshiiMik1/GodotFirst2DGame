extends Control

func _ready() -> void:
	for btn in $VBoxContainer.get_children():
		btn.connect("pressed",Callable(self,"on_pressed").bind(btn.name))

func on_pressed(btn_name:StringName):
	if btn_name == "New Game":
		get_tree().change_scene_to_file("res://Level/Game.tscn")
	elif btn_name == "Quit":
		get_tree().quit()
