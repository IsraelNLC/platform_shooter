extends Area2D

var speed = 1500
var directionVector : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func shoot(delta):
	position += directionVector * speed * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shoot(delta)


func _on_body_entered(body):
	queue_free()
