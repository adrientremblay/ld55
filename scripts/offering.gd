class_name Offering extends Node2D

var platforms_entered = []
var old_platform = null
var offset: Vector2
var initial_pos
var being_dragged = false
var can_be_dragged = false

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click") and can_be_dragged:
		offset = get_global_mouse_position() - global_position
		initial_pos = global_position
		if platforms_entered.size() == 1:
			being_dragged = true
			platforms_entered[0].placed_offering = null
			old_platform = platforms_entered[0]
	if Input.is_action_pressed("click") and being_dragged:
		global_position = get_global_mouse_position() - offset
	elif being_dragged and Input.is_action_just_released("click"):
		being_dragged = false
		var tween = get_tree().create_tween()
		if platforms_entered.size() == 1 and platforms_entered[0].placed_offering == null:
			tween.tween_property(self, "global_position", platforms_entered[0].global_position, 0.2).set_ease(Tween.EASE_OUT)
			platforms_entered[0].placed_offering = self
		elif initial_pos != null:
			tween.tween_property(self, "global_position", initial_pos, 0.2).set_ease(Tween.EASE_OUT)
			if old_platform != null:
				old_platform.placed_offering = self

func _on_area_2d_mouse_entered() -> void:
	can_be_dragged = true
	scale = Vector2(1.1, 1.1)

func _on_area_2d_mouse_exited() -> void:
	can_be_dragged = false
	scale = Vector2(1.0, 1.0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("droppable"):
		return
		
	body.modulate = Color(Color.WHITE, 0.7)
	platforms_entered.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	platforms_entered.erase(body)
	body.modulate = Color(Color.WHITE, 1.0)
