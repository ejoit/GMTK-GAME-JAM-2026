extends Node2D


@onready var timer = $Node/Timer
@onready var label = $Node/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Node/Timer.start()
	add_to_group("Countdown")

# Called every frame. 'delta' is the elapsed time since the previous frame.

	
	
func time_left_till_boom():
	var time_left = $Node/Timer
	
	
func _process(delta: float) -> void:
	label.text = str(round(timer.time_left))

func _on_timer_timeout() -> void:
	get_tree().quit()


func _on_plus_time_timerplus() -> void:
	$Node/Timer.start($Node/Timer.time_left + 10.0)


func _on_minus_time_timerminus() -> void:
	pass # Replace with function body.
