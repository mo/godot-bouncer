extends Node2D

var BlockScene: PackedScene = preload("./block.tscn")
var cols := 45
var rows := 45
var speed = 2000
var balls: Array[CharacterBody2D] = []

func layermask(layers: Array) -> int:
	var bitmask = 0
	for layer in layers:
		bitmask |= 1 << (layer - 1)
	return bitmask

func _ready():
	var screenSize = get_viewport_rect().size
	var blockWidth = screenSize.x / cols
	var blockHeight = screenSize.y / rows
	for y in rows:
		for x in cols:
			var block: StaticBody2D = BlockScene.instantiate()
			block.position = Vector2(x * blockWidth, y * blockHeight)
			block.scale = Vector2(blockWidth / 100, blockHeight / 100)
			var isInBottomLeftCorner = block.position.distance_to(Vector2(0, screenSize.y)) < block.position.distance_to(Vector2(screenSize.x, 0))
			if isInBottomLeftCorner:
				block.get_node("ColorRect").color = Color.WHITE
				block.collision_layer = layermask([2]) # move block to collision layer 3
			else:
				block.get_node("ColorRect").color = Color.BLACK
				block.collision_layer = layermask([3]) # move block to collision layer 2
			$BlocksContainer.add_child(block)
	balls = [
		Ball.create(Color.WHITE, Vector2(screenSize.x * 0.8, screenSize.y * 0.2), layermask([4]), layermask([1, 2])),
		Ball.create(Color.BLACK, Vector2(screenSize.x * 0.2, screenSize.y * 0.8), layermask([5]), layermask([1, 3]))
	]
	for ball in balls:
		add_child(ball)

func _physics_process(delta):
	for ball in balls:
		var collision = ball.move_and_collide(ball.direction * speed * delta)
		if collision:
			var collider = collision.get_collider()
			if collider == get_node("ScreenEdges"):
				ball.direction = ball.direction.bounce(collision.get_normal())
			elif collider is Block:
				ball.direction = ball.direction.bounce(collision.get_normal())
