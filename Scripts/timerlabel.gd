extends Node

@onready var label = $Label
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(_delta):
	label.text = str(ceil(timer.time_left))
