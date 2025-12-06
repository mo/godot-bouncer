extends CharacterBody2D
class_name Ball

@export var direction: Vector2
@export var avgSpeed: int
@export var speedAngle: float

static func create(color: Color, ballPosition: Vector2, ballDirection: Vector2, ballAvgSpeed: int, ballSpeedAngle: float, collisionLayer: int, collisionMask: int):
	var ball: CharacterBody2D = load("./ball.tscn").instantiate()	
	ball.get_node("ColorRect").color = color
	ball.position = ballPosition
	ball.direction = ballDirection
	ball.avgSpeed = ballAvgSpeed
	ball.speedAngle = ballSpeedAngle
	ball.collision_layer = collisionLayer
	ball.collision_mask = collisionMask
	return ball
