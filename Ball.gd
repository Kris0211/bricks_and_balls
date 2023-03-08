extends CharacterBody2D

@export var ball_speed := 3
var dir_x: float = -1.2
var dir_y: float = -1

func _physics_process(_delta):
	velocity.x = ball_speed * dir_x
	velocity.y = ball_speed * dir_y
	var collision = move_and_collide(velocity)
	if collision != null:
		$AudioStreamPlayer.play()
		var body = collision.get_collider()
		if body.is_in_group("wall_side"):
			dir_x *= -1
		if body.is_in_group("wall_up"):
			dir_y *= -1
		if body.is_in_group("brick"):
			body.call("destroy_yourself")
			dir_y *= -1
		if body.is_in_group("player"):
			dir_y *= randf_range(-0.5 , -1);
		if body.is_in_group("ball"):
			queue_free()
		if body.is_in_group("death"):
			pass
			#get_tree().reload_current_scene()
