extends Node2D

var matrix = PoolVector2Array()
var matrix_units = PoolVector2Array()

var starting_pos = Vector2(32, 32)
var goal_pos = Vector2(1056,160)

var block_size = 64
var mouse_pos_units
var target_pos_units

var path = PoolVector2Array()
var shortestPath = PoolVector2Array()

var points = load("res://point.tscn")

var pointsOn = false
var pathOn = false
var start = false

func _ready():
	_createMap()
	_instantiatePoints()

func _createMap():
	for i in Globals.height:
		for j in Globals.width:
			var current_position = Vector2(starting_pos.x+block_size*j,starting_pos.y+block_size*i)
			matrix.append(current_position)
			matrix_units.append(Vector2(j,i))
			if $Mouse.position == current_position:
				mouse_pos_units = i*Globals.width + j
func _colorNodes():
	var color = Color(0, 1, 0.184314)
	if pathOn:
		color = Color(255,255,0)
	Globals.points[mouse_pos_units].colorNode(color)
	for path in shortestPath:
		for node in Globals.points:
			if path == node.global_position:
				node.colorNode(color)
func _instantiatePoints():
	for i in Globals.height*Globals.width:
		var point = points.instance()
		add_child(point)
		point.global_position = matrix[i]
		point.tileMapPosition = matrix_units[i]
		point.get_child(1).text = str(matrix_units[i])
		Globals.points.append(point)
func _dijkstras(var target):
	var neighbours = _getPointNeighbours(target)
	var nextPoint
	
	target.visited = true
	if target.global_position == goal_pos:
		return 1
	if neighbours.size() <= 0:
		return INF
		
	for point in neighbours:
		var returnValue = _dijkstras(point)
		if  returnValue != INF:
			nextPoint = point
			continue
		if neighbours.size() <= 1:
			neighbours.erase(point)
			return INF

	if nextPoint == null:
		return INF
	shortestPath.append(nextPoint.global_position)
	return 1
func _getPointNeighbours(var point):
	var neighbours = []
	for p in point._getNeighbours():
		if $TileMap.get_cell(p.tileMapPosition.x,p.tileMapPosition.y) != 0 && !p.visited:
			neighbours.append(p)
	return neighbours


func _on_UI_pathOnSignal():
	pathOn = !pathOn
	_colorNodes()
func _on_UI_pointsOnSignal():
	pointsOn = !pointsOn
	for point in Globals.points:
		point.visible = pointsOn
func _on_UI_startSignal():
	if start == false:
		_dijkstras(Globals.points[mouse_pos_units])
		$Mouse._followPath(shortestPath)
		$UI/PathButton/PathButton.disabled = false
		$UI/PathButton/Label.modulate = Color.white
		start = true
