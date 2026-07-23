extends Node2D

signal TIMERPLUS
@onready var collision = $Area2D/CollisionShape2D
@onready var used = false
@export var minusmoves = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.set_text(str(minusmoves))
@onready var minus: AudioStreamPlayer2D = $AudioStreamPlayer2D


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("enter")
	if body.is_in_group("player"):
		if used == false:
			body.moves -= minusmoves
			minus.play()
			$Area2D.monitoring = false
			$Area2D.monitorable = false
			$Sprite2D.hide()
			$Label.visible = false
			print("player enter")
			used = true

		else:
			print("NO")
 
