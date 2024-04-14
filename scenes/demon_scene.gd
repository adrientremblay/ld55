extends Control

var demon: Demon
var line_i = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DemonFace.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible == false:
		return
		
	if Input.is_action_just_pressed("click"):
		line_i += 1
		if (line_i >= demon.lines.size()):
			banish()
		else:
			$SpeechBubble.text = demon.lines[line_i]
	
func summon(demon: Demon):
	self.demon = demon
	visible = true
	line_i = 0
	$SpeechBubble.text = demon.lines[line_i]

func banish():
	visible = false
	# TODO load next level
