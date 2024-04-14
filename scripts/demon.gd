class_name Demon extends Object

var name: String
var description: String
var cols: Array
var rows: Array
var lines: Array
var instructions: String
var level: int #ised for the difficulty calculation

var rng = RandomNumberGenerator.new()

func _init(level, name, description, cols, rows, lines, instructions):
	self.name = name
	self.description = description
	
	if cols != null and rows != null:
		self.cols = cols
		self.rows = rows
	else:
		var puzzle = generate_puzzle()
		self.rows = puzzle[0]
		self.cols = puzzle[1]
	
	if lines.size() != 0:
		self.lines = lines
	else:
		self.lines = ["Hello I am a demon"]

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
