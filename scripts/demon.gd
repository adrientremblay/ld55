class_name Demon extends Object

var name: String
var description: String
var cols: Array
var rows: Array
var lines: Array
var instructions: String
var level: int #ised for the difficulty calculation
var required_offerings: Array

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
		self.required_offerings = puzzle[2]
	
	if lines.size() != 0:
		self.lines = lines
	else:
		self.lines = ["Hello I am a demon"]

func generate_puzzle(level):
	var rows = [0,0,0,0,0]
	var cols = [0,0,0,0,0]
	
	var candle_density = 0.5
	var skull_density = 0.5
	var blood_density = 0.5
	match level:
		1:
			candle_density = 0.2
			skull_density = 0.0
			blood_density = 0.0
		2: 
			candle_density = 0.4
			skull_density = 0.0
			blood_density = 0.0
		3: 
			candle_density = 0.2
			skull_density = 0.05
			blood_density = 0.0
		4:
			candle_density = 0.2
			skull_density = 0.1
			blood_density = 0.05
		5:
			candle_density = 0.05
			skull_density = 0.2
			blood_density = 0.1
	
	var total_candles = 0
	var total_skulls = 0
	var total_bloods = 0
	
	var placed_something = [[false, false, false, false, false],[false, false, false, false, false],[false, false, false, false, false],[false, false, false, false, false],[false, false, false, false, false]]
	
	for i in range(5):
		for j in range(5):
			var placed_offering_value = 0
			
			if rng.randf() < skull_density:
				placed_offering_value = 2
				total_skulls += 1
				placed_something[i][j] = true
			elif rng.randf() < candle_density:
				placed_offering_value = 1
				total_candles += 1
				placed_something[i][j] = true
			
			rows[i] += placed_offering_value
			cols[j] += placed_offering_value
	
	for i in range(5):
		for j in range(5):
			if not placed_something[i][j] and rng.randf() < blood_density:
				var value_added = 0
				if i > 0 and placed_something[i-1][j]:
					rows[i-1] += 1
					cols[j] += 1
				if i < 4 and placed_something[i+1][j]:
					rows[i+1] += 1
					cols[j] += 1
				if j > 0 and placed_something[i][j-1]:
					rows[i] += 1
					cols[j-1] += 1
				if j < 4 and placed_something[i][j+1]:
					rows[i] += 1
					cols[j+1] += 1
				placed_something[i][j] = true
				total_bloods += 1
			
	return [rows, cols, [total_candles, total_skulls, total_bloods]]
