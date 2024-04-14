extends Node2D

signal spawn_object(object)

var object_scene = preload("res://scenes/offering.tscn")
var can_spawn = false
@export var type: Offering.OfferingType = Offering.OfferingType.CANDLE
var candles_texture: Texture2D = load("res://assets/images/candle_crate.png")
var skulls_texture:Texture2D = load("res://assets/images/pile_of_bones.png")
var total_offerings = 0

signal altar_check

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match type:
		Offering.OfferingType.CANDLE:
			$Sprite2D.texture = candles_texture
			$Label.text = "candles"
		Offering.OfferingType.SKULL:
			$Sprite2D.texture = skulls_texture
			$Label.text = "skulls"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.game_paused or not visible:
		return
	
	if (Input.is_action_just_pressed("click") and can_spawn):
		var object_instance = object_scene.instantiate()
		object_instance.set_type(type)
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
