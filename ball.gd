extends CharacterBody2D
class_name Ball

@export var direction = Vector2(1,-2).normalized()

static func create(color: Color, ballPosition: Vector2, collisionLayer: int, collisionMask: int):
	var ball: CharacterBody2D = load("./ball.tscn").instantiate()	
	ball.get_node("ColorRect").color = color
	ball.position = ballPosition
	ball.collision_layer = collisionLayer
	ball.collision_mask = collisionMask
	return ball
