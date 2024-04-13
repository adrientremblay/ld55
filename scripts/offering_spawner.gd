extends Node2D

signal spawn_object(object)

var object_scene = preload("res://scenes/offering.tscn")
var can_spawn = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("click") and can_spawn):
		var object_instance = object_scene.instantiate()
		object_instance.global_position = get_global_mouse_position()
		spawn_object.emit(object_instance)

func _on_area_2d_mouse_entered() -> void:
	can_spawn = true


func _on_area_2d_mouse_exited() -> void:
	can_spawn = false
