extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Dragging.is_dragging:
		modulate = Color(Color.WHITE, 0.7)
	else:
		modulate = Color(Color.WHITE, 1.0)
