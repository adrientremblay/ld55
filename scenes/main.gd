extends Node2D

var demons_to_summon: Array[Demon]
var current_demon = 0
@onready var demonNameLabel: Label = $Grimoire/DemonName
@onready var demonDescription: Label = $Grimoire/Description

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
	demons_to_summon.append(Demon.new("Abaddon", "Demon of Desolation and Ruin", null, null))
	demons_to_summon.append(Demon.new("Moloch", "Demon of Wrath and Violence", null, null))
	demons_to_summon.append(Demon.new("Astaroth", "Demon of Vanity and Envy", null, null))
	demons_to_summon.append(Demon.new("Belial", "Demon of Lawlessness and Corruption", null, null))
	demons_to_summon.append(Demon.new("Lilith ", "Demon of Deception and Betrayal", null, null))
	demons_to_summon.append(Demon.new("Leviathan", "Demon of Chaos and Destruction", null, null))
	demons_to_summon.append(Demon.new("Beelzebub", "Demon of Gluttony and Excess", null, null))
	demons_to_summon.append(Demon.new("Asmodeus", "Demon of Lust and Temptation", null, null))

func load_demon(demon: Demon):
	demonNameLabel.text = demon.name
	demonDescription.text = demon.description
	
	$Altar.set_answers(demon.rows, demon.cols)

func _on_object_check_if_puzzle_complete() -> void:
	print('checking')
