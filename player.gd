extends CharacterBody2D

@onready var crosshair = $crosshair
@onready var timer = $Timer

var bullet = preload("res://bullet.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_pressed("shoot") and timer.is_stopped(): 
		var newBullet = bullet.instantiate()
		newBullet.position = position + Vector2(0, -5)
		newBullet.directionVector = (crosshair.global_position - position).normalized()
		get_parent().add_child(newBullet)
		timer.start()

	move_and_slide()

func _process(delta):
	follow_mouse()

func follow_mouse(): 
	crosshair.global_position = get_viewport().get_mouse_position()
	return
