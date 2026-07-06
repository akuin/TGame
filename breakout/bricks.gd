extends Node3D

const ROWS := 3
const COLS := 8
const SPACING_X := 1
const SPACING_Y := 1

@export var brick_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_bricks()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

var row_colors: Array[Color] = [
	Color.RED,
	Color.ORANGE,
	Color.YELLOW,
	Color.GREEN,
	Color.BLUE,
]

func spawn_bricks():
	for row in ROWS:
		for col in COLS:
			var brick = brick_scene.instantiate()
			add_child(brick)
			brick.position = Vector3(
				(col - (COLS - 1) / 2.0) * SPACING_X,
				-row * SPACING_Y,
				0
			)
			apply_row_color(brick, row_colors[row % row_colors.size()])

func apply_row_color(brick: Node, color: Color):
	var mesh_instance := brick.get_node("MeshInstance3D") as MeshInstance3D
	if mesh_instance:
		var mat := StandardMaterial3D.new()
		mat.albedo_color = color
		mesh_instance.material_override = mat
