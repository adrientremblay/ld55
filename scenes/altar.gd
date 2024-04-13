extends Node2D

var platform_matrix = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_platform_matrix()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func populate_platform_matrix():
	for i in range(5):
		for j in range(5):
			var platform_num = i+j+1
			var platform = get_node("Platform" + str(platform_num))
			
			if i == 0:
				platform_matrix.append(Array())
				
			platform_matrix.append(platform)
