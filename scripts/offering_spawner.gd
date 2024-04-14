extends Node2D

signal spawn_object(object)

var object_scene = preload("res://scenes/offering.tscn")
var can_spawn = false
@export var type: Offering.OfferingType = Offering.OfferingType.CANDLE
var candles_texture: Texture2D = load("res://assets/images/candle_crate.png")
var skulls_texture:Texture2D = load("res://assets/images/pile_of_bones.png")
var total_offerings = 0
var offering_name

signal altar_check

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match type:
		Offering.OfferingType.CANDLE:
			$Sprite2D.texture = candles_texture
			offering_name = "candles"
		Offering.OfferingType.SKULL:
			$Sprite2D.texture = skulls_texture
			offering_name = "skulls"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.game_paused or not visible:
		return
	
	if (Input.is_action_just_pressed("click") and can_spawn and total_offerings > 0):
		var object_instance = object_scene.instantiate()
		object_instance.set_type(type)
		object_instance.global_position = get_global_mouse_position()
		object_instance.being_dragged = true
		object_instance.check_if_puzzle_complete.connect(ask_altar_to_check_game_completion)
		object_instance.return_offering.connect(return_offering)
		spawn_object.emit(object_instance)
		
		total_offerings -=1
		setLabel()

func _on_area_2d_mouse_entered() -> void:
	can_spawn = true
	scale = Vector2(1.1,1.1)

func ask_altar_to_check_game_completion():
	altar_check.emit()

func _on_area_2d_mouse_exited() -> void:
	can_spawn = false
	scale = Vector2(1.0,1.0)

func setLabel():
	$Label.text = offering_name + " (" + str(total_offerings) + ")"

func return_offering():
	total_offerings += 1
	setLabel()
