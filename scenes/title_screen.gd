extends Control

var slide = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Slide1.visible = true
	$Slide2.visible = false
	$Slide3.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		match slide:
			1:
				$Slide1.visible = false
				$Slide2.visible = true
			2:
				$Slide2.visible = false
				$Slide3.visible = true
			3:
				get_tree().change_scene_to_file("res://scenes/main.tscn")
		slide+=1
