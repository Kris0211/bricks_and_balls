extends StaticBody2D

signal give_points(points)

func destroy_yourself():
	emit_signal(&"give_points", 420)
	queue_free()
