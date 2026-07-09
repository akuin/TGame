extends Node3D

var score = 0
var lives = 0
var state = 0

#Restart later = `get_tree().reload_current_scene()`.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ball = get_parent().get_node("Ball")
	ball.ball_lost.connect(_on_ball_lost)
	ball.brick_broken.connect(_on_brick_broken)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_brick_broken() -> void:
	score += 100
	print("Score: ", score)
	
func _on_ball_lost() -> void:
	score -= 200
	print("Score: ", score)
