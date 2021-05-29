extends KinematicBody2D

const MOVE_SPEED = 300
onready var _animated_sprite = $AnimatedSprite #reference to player

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
	move_vect = move_vect.normalized()
	move_and_collide(move_vect * MOVE_SPEED * delta)
	
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
		
