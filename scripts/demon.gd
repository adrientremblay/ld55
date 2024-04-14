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
	self.level = level
	self.instructions = instructions
	
	if cols != null and rows != null:
		self.cols = cols
		self.rows = rows
	else:
		var puzzle = generate_puzzle(level)
		self.rows = puzzle[0]
		self.cols = puzzle[1]
	
	if lines.size() != 0:
		self.lines = lines
	else:
		self.lines = ["Hello I am a demon"]

func generate_puzzle(level):
	var rows = [0,0,0,0,0]
	var cols = [0,0,0,0,0]
	
	var candle_density = 0.5
	match level:
		1:
			candle_density = 0.2
		2: 
			candle_density = 0.4
		3: 
			candle_density = 0.6
	
	for i in range(5):
		for j in range(5):
			var should_place = rng.randf() < candle_density
			if should_place:
				rows[i]+=1
				cols[j]+=1
	
	return [rows, cols]
