extends Node3D

enum State { PLAYING, WON, LOST }


var score = 0
var lives = 3
var state := State.PLAYING



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
	
	await get_tree().process_frame
	if get_tree().get_nodes_in_group("Bricks").is_empty():
		_set_state(State.WON)
	
func _on_ball_lost() -> void:
	score -= 200
	lives -= 1
	print("Life lost! Lives remaining: ", lives)
	
	if lives <= 0:
		_set_state(State.LOST)


func _set_state(new_state: State) -> void:
	state = new_state
	var ball = get_parent().get_node("Ball")

	match state:
		State.WON:
			print("You won!")
			ball.set_physics_process(false)
		State.LOST:
			print("Game over!")
			ball.set_physics_process(false)
