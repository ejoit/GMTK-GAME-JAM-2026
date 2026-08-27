extends Node

signal moves_changed(new_value: int)

var g_moves_left: int = 0:
	set(value):
		if g_moves_left == value:
			return
		g_moves_left = value
		moves_changed.emit(g_moves_left)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
