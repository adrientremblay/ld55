extends Node2D

signal spawn_object(object)

var object_scene = preload("res://scenes/offering.tscn")
var can_spawn = false

signal altar_check

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.game_paused:
		return
	
	if (Input.is_action_just_pressed("click") and can_spawn):
		var object_instance = object_scene.instantiate()
		object_instance.global_position = get_global_mouse_position()
		object_instance.being_dragged = true
		object_instance.check_if_puzzle_complete.connect(ask_altar_to_check_game_completion)
		spawn_object.emit(object_instance)

func _on_area_2d_mouse_entered() -> void:
	can_spawn = true
	scale = Vector2(1.1,1.1)

func ask_altar_to_check_game_completion():
	altar_check.emit()

func _on_area_2d_mouse_exited() -> void:
	can_spawn = false
	scale = Vector2(1.0,1.0)
