extends CharacterBody3D


const SPEED = 5
const JUMP_VELOCITY = 4.5
const START_POS := Vector3(0.0, 0.5, 0.0)
const LOST_Y := -5.0


func _ready():
	velocity = Vector3(0,1,0) * SPEED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	if global_position.y < LOST_Y:
		emit_signal("ball_lost")
		_reset()
	#velocity += get_gravity() * delta * SPEED
	#velocity += Vector3(0,1,0) * delta * SPEED
	var col = move_and_collide(velocity * delta)
	
	if col:
		
		var normal = col.get_normal()

		if normal.dot(Vector3.UP) > 0.5:
			var paddle = col.get_collider()
			if "HALF_WIDTH" in paddle:
				var hit_factor = (global_position.x - paddle.global_position.x)
				velocity = Vector3(hit_factor, 1, 0).normalized() * SPEED
			else:
				velocity = velocity.bounce(col.get_normal())
		else:
				velocity = velocity.bounce(col.get_normal())
				
		if col.get_collider().is_in_group("Bricks"):
			col.get_collider().queue_free()
			print("point")
	
	velocity = velocity.normalized() * SPEED

func _reset() -> void:
	# Snap back to start and relaunch
	global_position = START_POS
	velocity = Vector3.ZERO
	_launch()

func _launch() -> void:
	velocity = Vector3(randf_range(-1.0, 1.0), 1.0, 0.0).normalized() * SPEED
