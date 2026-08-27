extends Node


var moves_left = Global.g_moves_left
var tween: Tween
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	$Label.text = str(Global.g_moves_left)   # show initial value
	if not Global.moves_changed.is_connected(_on_moves_changed):
		Global.moves_changed.connect(_on_moves_changed)
		
func _on_moves_changed(new_value: int) -> void:
	$Label.text = str(new_value)
	squash_stretch(Vector2(1.2, 0.8))


func squash_stretch(pop_scale: Vector2 = Vector2(1.3, 1.3)) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($Label, "scale", Vector2(1.3, 1.3), 0.15)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)

	tween.tween_property($Label, "scale", Vector2.ONE, 0.15)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_IN)

var muted_icon = preload("res://Sprites/mute.png")
var unmuted_icon = preload("res://Sprites/play.png")
var sfx_bus_index = AudioServer.get_bus_index("SFX")
var pause_sound = false
var sfx_off = false

func _on_button_pressed() -> void:
	$click.play()
	if pause_sound == false:
		$Button.texture_normal = muted_icon
		music.stop()
		pause_sound = true
	
	elif pause_sound == true:
		$Button.texture_normal = unmuted_icon
		music.play()
		pause_sound = false


func _on_button_2_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().reload_current_scene()


func _on_button_3_pressed() -> void:
	if sfx_off == false:
		$Button3.texture_normal = muted_icon
		AudioServer.set_bus_mute(sfx_bus_index, true)
		sfx_off = true
	
	elif sfx_off == true:
		$Button3.texture_normal = unmuted_icon
		AudioServer.set_bus_mute(sfx_bus_index, false)
		sfx_off = false
