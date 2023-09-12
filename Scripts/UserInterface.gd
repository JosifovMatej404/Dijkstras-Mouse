extends Control

signal pointsOnSignal
signal pathOnSignal
signal startSignal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Button_pressed():
	emit_signal("startSignal")


func _on_PointsButton_pressed():
	emit_signal("pointsOnSignal")


func _on_PathButton_pressed():
	emit_signal("pathOnSignal")
