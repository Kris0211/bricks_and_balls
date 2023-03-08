extends Node2D

@export var rows := 5
@export var ball_count := 3
var score: int = 0

const BRICK_COLORS = [Color("#f00"), Color("#0f0"), Color("#00f"), 
		Color("#ff0"), Color("#f0f"), Color("#0ff")]

var brick = preload("res://Brick.tscn")
var ball = preload("res://Ball.tscn")

@onready var brick_container = $Bricks
@onready var balls = $Balls
@onready var rngesus = RandomNumberGenerator.new()

func _ready() -> void:
	rngesus.randomize()
	generate_bricks(rows)
	for i in range(0, ball_count):
		create_ball()
	$Control/Label2.set_text("Best: " + str(HighScore.high_score))


func _process(_delta):
	var kids = $Bricks.get_child_count() # no dzieci?
	if kids == 0:
		generate_bricks(rows + 1)
	#var kids_balls = $Balls.get_child_count()
	#if kids_balls == 0:
	#	get_tree().reload_current_scene()


func generate_bricks(_rows: int) -> void:
	for ball in balls.get_children():
		ball.queue_free()
	for i in range(50):
		for k in range(_rows):
			var brick_instance = brick.instantiate()
			brick_instance.position = Vector2(64 * i + 32, 64 * k + 32)
			brick_instance.modulate = BRICK_COLORS[randi_range(0, 5)]
			brick_instance.connect(&"give_points", self.update_score)
			brick_container.add_child(brick_instance)


func create_ball() -> void:
	var ball_instance = ball.instantiate()
	ball_instance.position = Vector2(400 + randi_range(-120, 120), 600)
	ball_instance.velocity.x = randf_range(-1.0, 1.0)
	self.add_child(ball_instance)


func update_score(points: int):
	create_ball()
	score += points
	$Control/Label.set_text("Score: " + str(score))
	if score >= HighScore.high_score:
		HighScore.high_score = score
		$Control/Label2.set_text("Best: " + str(score))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacja"):
		create_ball()
