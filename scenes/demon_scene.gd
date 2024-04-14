extends Control

var demon: Demon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DemonFace.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible == false:
		return
	
func summon(demon: Demon):
	self.demon = demon
	self.visible = true
	$SpeechBubble.text = demon.lines[0]
