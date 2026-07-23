extends Node2D
@export var next_level = ""

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("aaaaaaa")
	if body.is_in_group("player"):
		body.ingoal = true

		
		if body.ingoal == true and body.zeromoves == true:
			get_tree().change_scene_to_file(next_level)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("goal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass
	#body.ingoal = false
