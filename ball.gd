extends CharacterBody2D

var speed = 1000
var dir = Vector2(1,-1).normalized()

func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	if collision:
		var collider = collision.get_collider()
		if collider == $"../StaticBody2D":
			dir = dir.bounce(collision.get_normal())
