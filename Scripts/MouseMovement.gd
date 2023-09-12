extends KinematicBody2D

var targetPositions = PoolVector2Array()
var speed = 10000
var index = 0

func _physics_process(delta):
	if index < targetPositions.size():
		var distance = sqrt(
			pow(targetPositions[-index-1].x-global_position.x,2)+
			pow(targetPositions[-index-1].y-global_position.y,2))
		if distance < 2:
			index+=1
			return
		move_and_slide(_calculateVelocity(targetPositions[-index-1])*delta*speed)
func _calculateVelocity(var target):
	var angle = get_angle_to(target)
	var velocity = Vector2(cos(angle),sin(angle))
	return velocity
func _followPath(var vec2array):
	targetPositions = vec2array
