extends Area2D

@export var bullet_scene:PackedScene
@export var min_angle:float = -30.0
@export var max_angle:float = 30.0
@export var speed := 10.0
@export var duration:float = 2.0

var current_angle:float = 0.0
var direction:int = 1

func _ready() -> void:
	start_rotate()

func start_rotate()->void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($TankB/Weapon,"rotation_degrees",max_angle,duration)
	tween.tween_property($TankB/Weapon,"rotation_degrees",min_angle,duration)

#func _physics_process(delta: float) -> void:
	#current_angle += direction * speed * delta
	#if current_angle >= max_angle:
		#current_angle = max_angle
		#direction = -1
	#elif current_angle <= min_angle:
		#current_angle = min_angle
		#direction = 1
	#$TankB/Weapon.rotation_degrees = current_angle
	#for area in get_overlapping_areas():
		#print(area.name)
		#if area.is_in_group("sight"):
			#fire()


func fire() -> void:
	var muzzle_global_pos = $TankB/Weapon/Marker2D.global_position
	var fire_dir = (muzzle_global_pos - $TankB.global_position).normalized()
	var bullet = bullet_scene.instantiate()
	bullet.add_to_group("Enemy_bullet")
	get_tree().root.call_deferred("add_child",bullet)
	bullet.setup(muzzle_global_pos,fire_dir,$TankB/Weapon.global_rotation_degrees)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_bullet"):
		get_tree().call_group("Score","update_score",1)
		area.queue_free()
		queue_free()


func _on_sight_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		fire()
