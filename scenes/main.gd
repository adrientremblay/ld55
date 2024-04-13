extends Node2D

var demons_to_summon: Array[Demon]
var current_demon = 0
@onready var demonNameLabel: Label = $Grimoire/DemonName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_levels()
	load_demon(demons_to_summon[current_demon])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_object_spawner_spawn_object(object: Variant) -> void:
	add_child(object)

func make_levels():
	demons_to_summon.append(Demon.new("Abaddon", "sheep demon", [1,2,3,4,5], [1,2,3,4,5]))

func load_demon(demon: Demon):
	demonNameLabel.text = demon.name
	$Altar.set_answers(demon.rows, demon.cols)
