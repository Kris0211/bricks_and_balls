extends CharacterBody2D

@export var ball_speed := 3
var dir_x: float = randf_range(-1.0, 1.0)
var dir_y: float = -1

func _ready():
	velocity.x = randf_range(-5.0, 5.0)
	velocity.y = -1
	print(velocity.normalized())

func _physics_process(_delta):
	velocity = Vector2(dir_x, dir_y)
	var collision = move_and_collide(velocity.normalized() * ball_speed)
	if collision != null:
		$AudioStreamPlayer.play()
		var body := collision.get_collider()
		if body.is_in_group("wall_side"):
			dir_x *= -1
		if body.is_in_group("wall_up"):
			dir_y *= -1
		if body.is_in_group("brick"):
			body.call("destroy_yourself")
			dir_y *= -1
		if body.is_in_group("player"):
			dir_y *= -1
		if body.is_in_group("ball") or body.is_in_group("death"):
			explode()


func explode() -> void:
	queue_free()
