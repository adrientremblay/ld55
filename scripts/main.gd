extends Node2D

var debug_mode = true
var demons_to_summon: Array[Demon]
var current_demon = 0
@onready var demonNameLabel: Label = $Grimoire/Info/DemonName
@onready var demonDescription: Label = $Grimoire/Info/Description
@onready var levelLabel: Label = $Grimoire/Info/LevelLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_levels()
	load_demon(demons_to_summon[current_demon], 1)
	$DemonScene.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("skip_level"):
		level_complete()

func _on_object_spawner_spawn_object(object: Variant) -> void:
	add_child(object)

func make_levels():
	demons_to_summon.append(Demon.new(1, "Abaddon", "Demon of Desolation and Ruin", null, null, ["I am Abaddon! Am I the first demon you've ever seen?", "I can tell you men bring ruin upon themselves.", "But for the secrets of wrath and violence, you must consult Moloch!"], "Drag the candles onto the altar so that the sum of all rows and columns equals the goal numbers. Each candle has a value of 1."))
	demons_to_summon.append(Demon.new(2, "Moloch", "Demon of Wrath and Violence", null, null, ["I am Moloch! God of wrath and violence!", "I can tell you the secrets of spiteful men like you.", "You seek our knowledge for revenge perhaps?"], "Do the same as with the last level. There are more candles now."))
	demons_to_summon.append(Demon.new(3, "Astaroth", "Demon of Vanity and Envy", null, null, ["I am Astaroth! Write it down. You will be hearing of me a lot.", "Vanity and envy are the downfall of all men", "But will anyone remember your name when the world burns?"], "The next demon must be summoned using a combination of candles and skulls. Skulls have a value of 2"))
	#demons_to_summon.append(Demon.new("Belial", "Demon of Lawlessness and Corruption", null, null, []))
	#demons_to_summon.append(Demon.new("Lilith ", "Demon of Deception and Betrayal", null, null, []))
	#demons_to_summon.append(Demon.new("Leviathan", "Demon of Chaos and Destruction", null, null, []))
	#demons_to_summon.append(Demon.new("Beelzebub", "Demon of Gluttony and Excess", null, null))
	#demons_to_summon.append(Demon.new("Asmodeus", "Demon of Lust and Temptation", null, null))

func load_demon(demon: Demon, level_number: int):
	demonNameLabel.text = demon.name
	demonDescription.text = demon.description
	levelLabel.text = "Level " + str(level_number)
	
	$Altar.set_answers(demon.rows, demon.cols)
	$Grimoire/InstructionsContainer/InstructionsDescription.text = demon.instructions
	
	if level_number < 3:
		$SkullSpawner.visible = false
	else:
		$SkullSpawner.visible = true
	
	$CandleSpawner.total_offerings = demon.required_offerings[0]
	$CandleSpawner.setLabel()
	
	$SkullSpawner.total_offerings = demon.required_offerings[1]
	$SkullSpawner.setLabel()

func _on_object_spawner_altar_check() -> void:
	if $Altar.check_puzzle_completion():
		level_complete()

func level_complete():
	$Altar.clear_altar()
	
	var demon = demons_to_summon[current_demon]
	$DemonScene.summon(demon)

func _on_demon_scene_next_level() -> void:
	current_demon +=1
	if current_demon < demons_to_summon.size():
		load_demon(demons_to_summon[current_demon], current_demon+1)	
	else:
		get_tree().change_scene_to_file("res://scenes/end_scene.tscn")
