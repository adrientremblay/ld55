class_name Offering extends Node2D

var platforms_entered = []
var old_platform = null
var offset: Vector2
var initial_pos
var being_dragged = false
var can_be_dragged = false
var in_trash = false

signal check_if_puzzle_complete

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void: # TODO: this func is a bit messy
	if Global.game_paused:
		return
	
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
		if in_trash:
			self.queue_free()
			return	
		elif platforms_entered.size() > 1:
			var new_platform = find_closet_platform_entered()
			if (new_platform != null):
				tween.tween_property(self, "global_position", new_platform.global_position, 0.2).set_ease(Tween.EASE_OUT)
				new_platform.placed_offering = self
				check_if_puzzle_complete.emit()
		elif platforms_entered.size() == 1 and platforms_entered[0].placed_offering == null:
			tween.tween_property(self, "global_position", platforms_entered[0].global_position, 0.2).set_ease(Tween.EASE_OUT)
			platforms_entered[0].placed_offering = self
			check_if_puzzle_complete.emit()
		elif initial_pos != null:
			tween.tween_property(self, "global_position", initial_pos, 0.2).set_ease(Tween.EASE_OUT)
			if old_platform != null:
				old_platform.placed_offering = self
		elif old_platform == null:
			queue_free()

func _on_area_2d_mouse_entered() -> void:
	can_be_dragged = true
	scale = Vector2(1.1, 1.1)

func _on_area_2d_mouse_exited() -> void:
	can_be_dragged = false
	scale = Vector2(1.0, 1.0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("trash"):
		in_trash = true
		print("in trash")
		return
	
	if not body.is_in_group("droppable"):
		return
		
	body.modulate = Color(Color.WHITE, 0.7)
	platforms_entered.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("trash"):
		in_trash = false
		return
	
	if not body.is_in_group("droppable"):
		return
	
	platforms_entered.erase(body)
	body.modulate = Color(Color.WHITE, 1.0)
	
func find_closet_platform_entered():
	var closest_distance = -1.0
	var closest_platform = null
	
	for platform in platforms_entered:
		if platform.placed_offering != null:
			continue
		
		var distance_vector = platform.get_global_position() - self.get_global_position()
		var distance_magnitude = distance_vector.length()
		if closest_distance == -1.0 or closest_distance > distance_magnitude:
			closest_distance = distance_magnitude
			closest_platform = platform
		
	return closest_platform
