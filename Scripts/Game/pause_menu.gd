extends Control

func _ready() -> void:
	$background.set_size(get_viewport_rect().size)
	var resume:Button = $CenterContainer/VBoxContainer/Resume
	var quit:Button = $CenterContainer/VBoxContainer/Quit
	resume.connect("pressed",Callable(self,"on_pressed").bind(resume.name))
	quit.connect("pressed",Callable(self,"on_pressed").bind(quit.name))

func on_pressed(bname):
	if bname == "Resume":
		self.visible = false
		get_tree().paused = false
		get_tree().root.get_child(0).get_child(3).start()
		#get_tree().paused = false
	if bname == "Quit":
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Level/Main.tscn")

func _on_tank_a_pressed_pause() -> void:
	self.visible = true
