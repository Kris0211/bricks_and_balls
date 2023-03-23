extends CharacterBody2D

@export_range(1, 2137) var speed: int = 80;
var dir: int = 0

func _process(_delta) -> void:
	dir = 0
	if Input.is_action_pressed("move_left"):
		dir += -1
	if Input.is_action_pressed("move_right"):
		dir += 1
	dir = clamp(dir, -1, 1)
	velocity.x = speed * dir
	velocity.y = 0
	move_and_slide()
