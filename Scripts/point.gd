extends Node2D

export(Vector2) var tileMapPosition = Vector2()
export(bool) var visited = false
var neighbours = []


func _draw():
	if position.x < 16*64:
		draw_line(Vector2.ZERO, Vector2(64,0), Color(255,0,0), 1)
	if position.y < 10*64:
		draw_line(Vector2.ZERO, Vector2(0,64), Color(255,0,0), 1)
func _getNeighbours():
	for i in Globals.pointCount:
		if Globals.points[i].global_position.x == global_position.x && Globals.points[i].global_position.y == global_position.y-64:
			neighbours.append(Globals.points[i])
		if Globals.points[i].global_position.y == global_position.y && Globals.points[i].global_position.x == global_position.x+64:
			neighbours.append(Globals.points[i])
		if Globals.points[i].global_position.x == global_position.x && Globals.points[i].global_position.y == global_position.y+64:
			neighbours.append(Globals.points[i])
		if Globals.points[i].global_position.y == global_position.y && Globals.points[i].global_position.x == global_position.x-64:
			neighbours.append(Globals.points[i])
	return neighbours
func colorNode(var color):
	$Sprite.modulate = color
