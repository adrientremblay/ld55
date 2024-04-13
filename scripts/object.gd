extends Node2D

var draggable = false
var is_inside_droppable = false
var body_ref
var offset: Vector2
var initial_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not draggable:
		return
	if Input.is_action_just_pressed("click"):
		offset = get_global_mouse_position() - global_position
		initial_pos = global_position
		Dragging.is_dragging = true
	if Input.is_action_pressed("click"):
		global_position = get_global_mouse_position() - offset
	elif Input.is_action_just_released("click"):
		Dragging.is_dragging = false
		var tween = get_tree().create_tween()
		if is_inside_droppable:
			tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
		else:
			tween.tween_property(self, "global_position", initial_pos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered() -> void:
	if Dragging.is_dragging:
		return
		
	draggable = true
	scale = Vector2(1.1, 1.1)

func _on_area_2d_mouse_exited() -> void:
	if Dragging.is_dragging:
		return
		
	draggable = false
	scale = Vector2(1.0, 1.0)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("droppable"):
		return
		
	is_inside_droppable = true
	body.modulate = Color(Color.REBECCA_PURPLE, 1)
	body_ref = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if not body.is_in_group("droppable"):
		return
	
	is_inside_droppable = false
	body.modulate = Color(Color.REBECCA_PURPLE, 0.7)
