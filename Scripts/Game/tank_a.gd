extends Sprite2D

@export var bullet_scene:PackedScene
@export var fire_rate = 0.2

signal pressed_pause
var speed:float = 200.0
var can_fire : bool = true
var muzzle_offset := Vector2(0, -160)

func _ready() -> void:
	#self.position = Vector2(150,250)
	pass

func _process(delta: float) -> void:
	var horizontal = Input.get_axis("Move_left","Move_right")
	var vertical = Input.get_axis("Move_up","Move_down")
	if horizontal or vertical:
		$TrackL.play("Move")
		$TrackR.play("Move")
		if horizontal:
			self.position.x += horizontal * delta * speed
			self.rotation_degrees = -90.0 if horizontal == -1 else 90.0
		elif vertical:
			self.position.y += vertical * delta * speed
			self.rotation_degrees = 0.0 if vertical == -1 else 180.0
	else:
		$TrackL.play("Idle")
		$TrackR.play("Idle")
	horizontal = Input.get_axis("Rotate_left","Rotate_right")
	if horizontal:
		var weapon:Sprite2D = self.get_child(0)
		weapon.rotation_degrees += horizontal
	get_parent().get_child(0).global_position = self.global_position
	#get_parent().get_child(1).global_position = self.global_position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Fire") and can_fire:
		fire()
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
	if event.is_action_pressed("Pause"):
		get_tree().root.get_child(0).get_child(3).stop()
		pressed_pause.emit()
		get_tree().paused = true	

func fire() -> void:
	var muzzle_global_pos = $Weapon/bullet_tip.global_position
	var fire_direction = (muzzle_global_pos-self.global_position).normalized()
	var bullet = bullet_scene.instantiate()
	bullet.add_to_group("Player_bullet")
	get_tree().root.add_child(bullet)
	bullet.setup(muzzle_global_pos,fire_direction,$Weapon.global_rotation_degrees)
