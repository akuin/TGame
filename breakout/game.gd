extends Node3D

enum State { PLAYING, WON, LOST }


var score = 0
var lives = 3
var state := State.PLAYING

var _score_label : Label
var _lives_label : Label

var _message_label : Label



#Restart later = `get_tree().reload_current_scene()`.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ball = get_parent().get_node("Ball")
	ball.ball_lost.connect(_on_ball_lost)
	ball.brick_broken.connect(_on_brick_broken)
	
	_score_label = get_parent().get_node("Hud/CanvasLayer/Score")
	_lives_label = get_parent().get_node("Hud/CanvasLayer/Lives")
	
	_message_label = get_parent().get_node("Hud/CanvasLayer/GameOverPanel/MessageLabel")
	_message_label.get_parent().hide()
	
	_update_hud()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_brick_broken() -> void:
	score += 100
	print("Score: ", score)
	_update_hud()
	
	await get_tree().process_frame
	if get_tree().get_nodes_in_group("Bricks").is_empty():
		_set_state(State.WON)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and state != State.PLAYING:
		get_tree().reload_current_scene()
	 
func _on_ball_lost() -> void:
	score -= 200
	lives -= 1
	_update_hud()
	
	if lives <= 0:
		_set_state(State.LOST)


func _set_state(new_state: State) -> void:
	state = new_state
	var ball = get_parent().get_node("Ball")

	match state:
		State.WON:
			ball.set_physics_process(false)
			_message_label.text = "You Won!\nPress Space to restart"
			_message_label.get_parent().show()
		State.LOST:
			_message_label.text = "Game Over!\nPress Space to restart"
			_message_label.get_parent().show()
			ball.set_physics_process(false)

func _update_hud() -> void:
	_score_label.text = "Score: %d" % score
	_lives_label.text = "Lives: %d" % lives
