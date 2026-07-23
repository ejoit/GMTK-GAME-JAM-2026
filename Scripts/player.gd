extends CharacterBody2D

@export var moves = 0

var input_dir
var speed = 1
var tile_size = 8
var ingoal = false
func _ready() -> void:
	add_to_group("player")
	
@onready var walls =$"../TileMap/walls" # Change this to your TileMap's path


func _physics_process(delta: float) -> void:
	input_dir = Vector2.ZERO	
	if Input.is_action_just_pressed("ui_up"):
		input_dir = Vector2.UP
	elif Input.is_action_just_pressed("ui_down"):
		input_dir = Vector2.DOWN
	elif Input.is_action_just_pressed("ui_left"):
		input_dir = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_right"):
		input_dir = Vector2.RIGHT

	

	if input_dir != Vector2.ZERO:
		var next_pos = global_position + input_dir * tile_size
		var next_tile = walls.local_to_map(next_pos)
		
		if walls.get_cell_source_id(next_tile) == -1:
			global_position = lerp(position, next_pos, 8) 
			moves -= 1
		else:
			print("wall")
	
func _process(delta: float) -> void:
	Global.g_moves_left = moves
	if moves <= 0:
		await get_tree().create_timer(0.05).timeout
		if ingoal == false:
			get_tree().quit()
		elif ingoal == true:
			print("level win")
	if moves > 0 and ingoal == true:
					get_tree().quit()
	
	
	
