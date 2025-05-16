extends Area2D

@export var speed := 300.0
@export var margin := 50.0

var direction := Vector2.UP

func _ready() -> void:
	$VisibleOnScreenEnabler2D.screen_exited.connect(queue_free)
	$shoting.play()

func setup(start_pos:Vector2,move_dir:Vector2,degrees:float)->void:
	self.global_position = start_pos
	direction = move_dir
	self.rotation_degrees = degrees
	
func _physics_process(delta: float) -> void:
	self.position += direction.normalized() * speed * delta
	var viewport_rect = get_viewport_rect().grow(margin)
	if !viewport_rect.has_point(global_position):
		queue_free()
