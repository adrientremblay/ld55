extends Node2D

var platform_matrix = []
var col_labels = []
var row_labels = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_platform_matrix()
	populate_col_labels()
	populate_row_labels()
	update_col_labels()
	update_row_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#update_col_labels() # TODO: optimization (only run this when offerrings are placed
	#update_row_labels()

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
		var col_label = get_node("cols").get_node("y" + str(col_number))
		col_labels.append(col_label)
		
func populate_row_labels():
	for i in range(5):
		var row_number = i+1
		var row_label = get_node("rows").get_node("x" + str(row_number))
		row_labels.append(row_label)

func update_col_labels():
	for col in range(5):
		var col_count = 0;
		
		for platform_i in range(5):
			var platform = platform_matrix[platform_i][col]
			if (platform.placed_offering != null):
				col_count+=1;
		
		var label = col_labels[col]
		label.text = str(col_count)

func update_row_labels():
	for row in range(5):
		var row_count = 0;
		
		for platform_i in range(5):
			var platform = platform_matrix[row][platform_i]
			if (platform.placed_offering != null):
				row_count+=1;
		
		var label = row_labels[row]
		label.text = str(row_count)

func set_answers(answer_rows: Array, answer_cols: Array):
	for i in range(5):
		get_node("AnswerCols").get_node("y" + str(i+1)).text = str(answer_cols[i])
		get_node("AnswerRows").get_node("x" + str(i+1)).text = str(answer_rows[i])

func check_puzzle_completion():
	update_col_labels()
	update_row_labels()
	for i in range(5):
		var answer_col = get_node("AnswerCols").get_node("y" + str(i+1)).text
		var col = get_node("cols").get_node("y" + str(i+1)).text
		var answer_row = get_node("AnswerRows").get_node("x" + str(i+1)).text
		var row = get_node("rows").get_node("x" + str(i+1)).text
		
		if answer_col != col or answer_row != row:
			return false
		
	return true
