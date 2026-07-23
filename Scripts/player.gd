extends CharacterBody2D

@export var moves = 0

var input_dir
var moving = false
var speed = 1
var tile_size = 8
var ingoal = false
var zeromoves = false
var canmove = true
@onready var movesound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var die: AudioStreamPlayer2D = $AudioStreamPlayer2D2



func _ready() -> void:
	add_to_group("player")
	zeromoves = false
	ingoal = false
	
@onready var walls =$"../TileMap/walls" # Change this to your TileMap's path
@onready var doors = $"../TileMap/doors"
func wait_to_move():
	canmove = false
	await get_tree().create_timer(0.8).timeout
	canmove = true


var tween: Tween

func _physics_process(delta: float) -> void:
	
	if !canmove:
		return
	
	input_dir = Vector2.ZERO	
	
	if Input.is_action_just_pressed("ui_up"):
		movesound.play()
		input_dir = Vector2.UP
		squash_stretch(Vector2(0.8, 1.2))
	elif Input.is_action_just_pressed("ui_down"):
		movesound.play()
		input_dir = Vector2.DOWN
		squash_stretch(Vector2(0.8, 1.2))
	elif Input.is_action_just_pressed("ui_left"):
		movesound.play()
		input_dir = Vector2.LEFT
		squash_stretch(Vector2(1.2, 0.8))
	elif Input.is_action_just_pressed("ui_right"):
		movesound.play()
		input_dir = Vector2.RIGHT
		squash_stretch(Vector2(1.2, 0.8))

func squash_stretch(squash_scale: Vector2) -> void:
	if tween:
		tween.kill()  # stop any in-progress squash so they don't fight each other

	tween = create_tween()
	tween.tween_property($Sprite2D, "scale", squash_scale, 0.1)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($Sprite2D, "scale", Vector2.ONE, 0.2)\
		.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

	

	if input_dir != Vector2.ZERO:
		var next_pos = global_position + input_dir * tile_size
		var next_tile = walls.local_to_map(next_pos)

		
		
		if walls.get_cell_source_id(next_tile) == -1:
			
			var door_data = doors.get_cell_tile_data(next_tile)
			if door_data:
				var door_number = door_data.get_custom_data("DoorNumber")
				
				if door_number == moves:
					canmove = false
					moves -= 1
					var tween = create_tween()

					tween.tween_property(self, "global_position", next_pos, 0.15)
					await tween.finished
					canmove = true					
				else:
					print("Need key number: ", door_number)
			else:
				canmove = false
				moves -= 1
				var tween = create_tween()

				tween.tween_property(self, "global_position", next_pos, 0.15)
				await tween.finished
				canmove = true
		else:
				print("Need more")
		
		
	
func _process(delta: float) -> void:
	Global.g_moves_left = moves
	if moves <= 0:
		zeromoves = true
		await get_tree().create_timer(0.1).timeout
	if moves > 0 :
		zeromoves = false
		
	if zeromoves == true and ingoal == true:
		print("win")
		
	if zeromoves == true and ingoal == false:

		print("no moves")
		die.play()
		
		get_tree().reload_current_scene()
	if zeromoves == false and ingoal == true:
		print("no moves")
		die.play()

		get_tree().reload_current_scene()
