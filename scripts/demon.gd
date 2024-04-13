class_name Demon extends Object

var name: String
var description: String
var cols: Array
var rows: Array

var rng = RandomNumberGenerator.new()

func _init(name, description, cols, rows):
	self.name = name
	self.description = description
	if cols != null and rows != null:
		self.cols = cols
		self.rows = rows
	else:
		var puzzle = generate_puzzle()
		self.rows = puzzle[0]
		self.cols = puzzle[1]

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
