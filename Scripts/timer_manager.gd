extends Node


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var moves_left = Global.g_moves_left
	$RichTextLabel.set_text(str(moves_left))
