extends KinematicBody2D
var gravity= 50
var acceleration = 3

onready var ray: RayCast2D = get_node("path")
var velocity = Vector2()
const MOVE_SPEED = 300
onready var _animated_sprite = $AnimatedSprite #reference to player

#movement
func _physics_process(delta):
	var move_vect = Vector2()
	if Input.is_action_pressed("move_left"):
		if(_animated_sprite.get_animation() == "slash"):
			move_vect.x += 0
		else:
			move_vect.x -= 1
	if Input.is_action_pressed("move_right"):
		if(_animated_sprite.get_animation() == "slash"):
			move_vect.x += 0
		else:
			move_vect.x += 1
	if Input.is_action_pressed("move_up"):
		move_vect.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vect.y += 1
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= 600
		_animated_sprite.play("jump")
	move_vect = move_vect.normalized()

	velocity = velocity.linear_interpolate(move_vect * MOVE_SPEED, acceleration * delta)
	velocity.y += gravity

	# if Input.is_action_just_pressed("jump") and is_on_floor():
	# 	move_vect.y -= 10
	# 	_animated_sprite.play("jump")
		
	velocity = move_and_slide(velocity, Vector2(0,-1))
	#if 	!is_on_floor():
	#	move_vect.y += gravity * delta
		#move_and_collide(move_vect * MOVE_SPEED * delta)
	#else:
		#move_and_slide(move_vect, Vector2(0,-1))
	
	
func _process(delta):
	if Input.is_action_pressed("move_right"):
		_animated_sprite.set_flip_h(false)
		if Input.is_action_pressed("slash") &&  Input.is_action_pressed("move_right"):
			_animated_sprite.play("slash")
		else:
			_animated_sprite.play("walk")
	elif Input.is_action_pressed("move_left"):
		_animated_sprite.set_flip_h(true)
		if Input.is_action_pressed("slash") &&  Input.is_action_pressed("move_left"):
			_animated_sprite.play("slash")
		else:
			_animated_sprite.play("walk")
	elif Input.is_action_pressed("slash"):
		_animated_sprite.play("slash")
	else:
		_animated_sprite.play("default")
		
