extends Node2D

signal TIMERPLUS
@onready var collision = $Area2D/CollisionShape2D
@onready var used = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("enter")
	if body.is_in_group("player"):
		if used == false:
			body.moves += 5
			$Area2D.monitoring = false
			$Area2D.monitorable = false
			$Sprite2D.hide()
			print("player enter")
			used = true

		else:
			print("NO")
 
