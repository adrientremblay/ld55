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
	var skull_density = 0.5
	match level:
		1:
			candle_density = 0.2
			skull_density = 0.0
		2: 
			candle_density = 0.4
			skull_density = 0.0
		3: 
			candle_density = 0.6
			skull_density = 0.3
	
	for i in range(5):
		for j in range(5):
			var placed_offering_value = 0
			
			if rng.randf() < skull_density:
				placed_offering_value = 2
			elif rng.randf() < candle_density:
				placed_offering_value = 1
			
			rows[i] += placed_offering_value
			cols[j] += placed_offering_value
	
	return [rows, cols]
