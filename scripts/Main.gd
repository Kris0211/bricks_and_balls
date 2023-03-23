extends Node2D

@export var rows := 5
@export var ball_count := 3
var score: int = 0

const BRICK_COLORS = [Color("#f00"), Color("#0f0"), Color("#00f"), 
		Color("#ff0"), Color("#f0f"), Color("#0ff")]

@export var rave_mode: bool = false

var brick = preload("res://scenes/Brick.tscn")
var ball = preload("res://scenes/Ball.tscn")

@onready var brick_container = $Bricks
@onready var balls = $Balls
@onready var player = $Player
@onready var rngesus = RandomNumberGenerator.new()

func _ready() -> void:
	rngesus.randomize()
	generate_bricks(rows)
	for i in range(0, ball_count):
		create_ball()
	$Control/Label2.set_text("Best: " + str(HighScore.high_score))


func _process(_delta):
	if rave_mode:
		for b in brick_container.get_children():
			b.modulate = BRICK_COLORS[randi_range(0, 5)]
	if $Bricks.get_child_count() == 0:
		rows += 1
		generate_bricks(rows)
	if $Balls.get_child_count() == 0:
		get_tree().reload_current_scene()


func generate_bricks(_rows: int) -> void:
	for b in balls.get_children():
		b.queue_free()
	for i in range(10):
		for k in range(_rows):
			var brick_instance = brick.instantiate()
			brick_instance.position = Vector2(64 * i + 32, 64 * k + 32)
			brick_instance.modulate = BRICK_COLORS[randi_range(0, 5)]
			brick_instance.connect(&"give_points", self.update_score)
			brick_container.add_child(brick_instance)


func create_ball() -> void:
	var ball_instance = ball.instantiate()
	ball_instance.position = player.position + Vector2(randi_range(-120, 120), -40)
	balls.add_child(ball_instance)


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
	if event.is_action_pressed("rave_mode"):
		rave_mode = not rave_mode
