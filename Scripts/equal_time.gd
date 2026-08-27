extends Node2D

signal TIMERPLUS
@onready var collision = $Area2D/CollisionShape2D
@onready var used = false
@export var equalmoves = 0
@onready var powerup: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.set_text(str(equalmoves))


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("enter")
	if body.is_in_group("player"):
		if used == false:
			powerup.play()
			body.moves = equalmoves
			$Area2D.monitoring = false
			$Area2D.monitorable = false
			$Sprite2D.hide()
			$Label.visible = false
			print("player enter")
			used = true

		else:
			print("NO")
 
