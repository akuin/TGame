extends CharacterBody3D

# How far the paddle can travel from center (in world units)
const HALF_WIDTH: float = 3.4

func _ready() -> void:
	# Keep the mouse visible — it drives the paddle
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(_delta: float) -> void:
	# Convert mouse X position to a world-space X coordinate
	var viewport_width: float = get_viewport().get_visible_rect().size.x
	var mouse_x: float = get_viewport().get_mouse_position().x

	# Map [0, viewport_width] → [-HALF_WIDTH, +HALF_WIDTH]
	var world_x: float = (mouse_x / viewport_width) * (HALF_WIDTH * 2.0) - HALF_WIDTH

	# Clamp so the paddle never leaves the play area
	world_x = clamp(world_x, -HALF_WIDTH, HALF_WIDTH)

	# Apply — only move on X, keep Y and Z locked
	global_position.x = world_x
