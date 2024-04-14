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
			if (platform.placed_offering == null):
				continue
				
			var platform_value
			match platform.placed_offering.type:
				Offering.OfferingType.CANDLE:
					platform_value = 1
				Offering.OfferingType.SKULL:
					platform_value = 2
				Offering.OfferingType.BLOOD:
					platform_value = 0
			
			platform_value += calculated_blood_value(platform_i, col)
			
			col_count += platform_value
		
		var label = col_labels[col]
		label.text = str(col_count)

func update_row_labels():
	for row in range(5):
		var row_count = 0;
		
		for platform_i in range(5):
			var platform = platform_matrix[row][platform_i]
			if (platform.placed_offering == null):
				continue
				
			var platform_value
			match platform.placed_offering.type:
				Offering.OfferingType.CANDLE:
					platform_value = 1
				Offering.OfferingType.SKULL:
					platform_value = 2
				Offering.OfferingType.BLOOD:
					platform_value = 0
			
			platform_value += calculated_blood_value(row, platform_i)
			
			row_count += platform_value
		
		var label = row_labels[row]
		label.text = str(row_count)

func set_answers(answer_rows: Array, answer_cols: Array):
	for i in range(5):
		get_node("AnswerCols").get_node("y" + str(i+1)).text = str(answer_cols[i])
		get_node("AnswerRows").get_node("x" + str(i+1)).text = str(answer_rows[i])
	check_puzzle_completion()

func check_puzzle_completion():
	var puzzle_complete = true
	
	update_col_labels()
	update_row_labels()
	for i in range(5):
		var answer_col = get_node("AnswerCols").get_node("y" + str(i+1))
		var col = get_node("cols").get_node("y" + str(i+1))
		var answer_row = get_node("AnswerRows").get_node("x" + str(i+1))
		var row = get_node("rows").get_node("x" + str(i+1))
		
		if answer_col.text != col.text or answer_row.text != row.text:
			puzzle_complete = false
			
		# updating label colors
		if answer_col.text != col.text:
			col.modulate = Color.RED
		else:
			col.modulate = Color.GREEN
			
		if answer_row.text != row.text:
			row.modulate = Color.RED
		else:
			row.modulate = Color.GREEN
		
	return puzzle_complete

func clear_altar():
	for i in range(5):
		for j in range(5):
			var platform_num = (i*5)+j+1 
			var platform = get_node("Platform" + str(platform_num))
			
			if platform.placed_offering:
				var offering = platform.placed_offering
				platform.placed_offering = null
				offering.queue_free()

func calculated_blood_value(i: int, j: int):
	var added_value = 0
	
	if i > 0 and platform_matrix[i-1][j].placed_offering != null and platform_matrix[i-1][j].placed_offering.type == Offering.OfferingType.BLOOD:
		added_value += 1
	if i < 4 and platform_matrix[i+1][j].placed_offering != null and platform_matrix[i+1][j].placed_offering.type == Offering.OfferingType.BLOOD:
		added_value += 1
	if j > 0 and platform_matrix[i][j-1].placed_offering != null and platform_matrix[i][j-1].placed_offering.type == Offering.OfferingType.BLOOD:
		added_value += 1
	if j < 4 and platform_matrix[i][j+1].placed_offering != null and platform_matrix[i][j+1].placed_offering.type == Offering.OfferingType.BLOOD:
		added_value += 1
	
	return added_value
