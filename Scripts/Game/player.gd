extends Area2D
@export var 	enemy_scene:PackedScene
#signal stop

#func _ready() -> void:
	#gen_enemy()

#func gen_enemy() ->void:
	#var enemy = enemy_scene.instantiate()
	#enemy.global_position = Vector2(200,100)
	#get_parent().add_child.call_deferred((enemy))
	##get_tree().root.add_child.call_deferred(enemy)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy_bullet"):
		#$Dead.visible = true
		#$Dead.play()
		#await $Dead.animation_finished
		area.queue_free()
		queue_free()
