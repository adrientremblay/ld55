extends Node2D

var platform_matrix = []
var col_labels = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_platform_matrix()
	populate_col_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_col_labels()

func populate_platform_matrix():
	for i in range(5):
		for j in range(5):
			var platform_num = (i*5)+j+1 
			var platform = get_node("Platform" + str(platform_num))
			
			if j == 0:
				platform_matrix.append(Array())
				
			platform_matrix[i].append(platform)

func populate_col_labels():
	for i in range(5):
		var col_number = i+1
		var col_label = get_node("y" + str(col_number))
		col_labels.append(col_label)

func update_col_labels():
	for col in range(5):
		var col_count = 0;
		
		for platform_i in range(5):
			var platform = platform_matrix[platform_i][col]
			if (platform.placed_offering != null):
				col_count+=1;
		
		var label = col_labels[col]
		label.text = str(col_count)
