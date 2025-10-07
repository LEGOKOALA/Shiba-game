extends CharacterBody2D

const SPEED = 60
const GRAVITY = 400
const MAX_FALL_SPEED = 300

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Gravity
	velocity.y += GRAVITY * delta
	velocity.y = min(velocity.y, MAX_FALL_SPEED)

	# Wall detection
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
		print("Right hit:", ray_cast_right.get_collider())
	elif ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		print("Left hit:", ray_cast_left.get_collider())
	
	print(direction)
	# Only walk when grounded
	if is_on_floor():
		velocity.x = direction * SPEED
	else:
		velocity.x = 0

	move_and_slide()
