extends Node

@export var enemy_scene:PackedScene

signal game_over
var id := 0

func _ready() -> void:
	$EnemyTimer.start()

func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	var enemy_spawn_location = $EnemyPath/PathFollow2D
	enemy_spawn_location.progress_ratio = randf()
	#enemy.position = enemy_spawn_location.position
	enemy.position = Vector2(200,100)
	enemy.name = "Enemy" + str(id)
	id += 1
	add_child(enemy)
	$EnemyTimer.stop()


func _on_player_tree_exited() -> void:
	$EnemyTimer.stop()
	game_over.emit()
