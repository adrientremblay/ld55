extends Node2D

var demons_to_summon: Array[Demon]
var current_demon = 0
@onready var demonNameLabel: Label = $Grimoire/DemonName

var rng = RandomNumberGenerator.new()

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
	var puzzle = generate_puzzle()
	var abaddon = Demon.new("Abaddon", "sheep demon", puzzle[0], puzzle[1])
	demons_to_summon.append(abaddon)

func load_demon(demon: Demon):
	demonNameLabel.text = demon.name
	$Altar.set_answers(demon.rows, demon.cols)

func generate_puzzle():
	var rows = [0,0,0,0,0]
	var cols = [0,0,0,0,0]
	
	for i in range(5):
		for j in range(5):
			var should_place = rng.randf() > 0.5
			if should_place:
				rows[i]+=1
				cols[j]+=1
	
	return [rows, cols]
