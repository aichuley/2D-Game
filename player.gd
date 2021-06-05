extends KinematicBody2D

var gravity= 50
var acceleration = 3
var count = 0
var anim = "default"
var flag = false # initialized outside process
signal finished

onready var raycast = $"/root/World/player/RayCast2D"
var velocity = Vector2()
const MOVE_SPEED = 300
onready var _animated_sprite = $AnimatedSprite #reference to player

#movement
func _physics_process(delta):
	var move_vect = Vector2()
	if Input.is_action_pressed("move_left"):
		#raycast.rotation_degrees = 90
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

	# var space_state = get_world_2d().direct_space_state
	# var result = space_state.intersect_ray(Vector2(0, 0), Vector2(50, 100))
	# if Input.is_action_pressed("slash"):
	# 	#check_collision()
	# 	if result:
	# 		print("Hit at point: ", result.position)
	
	

func _ready():
	if _animated_sprite.animation == "slash":
		_animated_sprite.connect("finished", self, "_on_AnimatedSprite_animation_finished")


func _process(delta):
	# var sStop = slashStop.new()
	# add_child(sStop)
	# if _animated_sprite.animation == "slash":
	# 	_animated_sprite.connect("finished", self, "_on_AnimatedSprite_animation_finished")
	# 	# sStop.connect("finished", self, "animation_done")
	# 	# yield(get_tree().create_timer(_animated_sprite.animation.length()), "animation_done")
		

#	else:
		
		
		if Input.is_action_pressed("move_right"):
			_animated_sprite.set_flip_h(false)
			_animated_sprite.play("walk")
		
			if Input.is_action_pressed("slash") &&  Input.is_action_pressed("move_right"):
				_animated_sprite.play("slash")
			else:
				_animated_sprite.play("walk")
		elif Input.is_action_pressed("move_left"):
			_animated_sprite.set_flip_h(true)
			_animated_sprite.play("walk")

			if Input.is_action_pressed("slash") &&  Input.is_action_pressed("move_left"):
				_animated_sprite.play("slash")
			else:
				_animated_sprite.play("walk")
		elif Input.is_action_pressed("slash"):
			_animated_sprite.play("slash")
		else:
			_animated_sprite.play("default")

func _on_AnimatedSprite_animation_finished(): 
		print("called")
		_animated_sprite.play("default")

# func _process(delta):
# 	var new_anim = anim

# 	if Input.is_action_just_pressed("slash") and flag == true:
# 		new_anim = "slash"
# 	if new_anim != anim and flag == true:
# 		anim = new_anim
# 		_animated_sprite.play(anim)
# 		if anim == "slash":
# 			flag = false
# 		else:
# 			flag = true



func check_collision():
	
	#raycast.force_raycast_update()
	if raycast.is_colliding():
		var collider = raycast.get_collider()
				
		if collider.is_in_group("Enemies"):
			collider.hit()
			print("hit " + collider.name)
		

# func _input(event):
# 	# if event is InputEventMouseButton:
# 	# 	if event.button_index == BUTTON_LEFT and event.pressed:
# 	# 		_animated_sprite.play("slash")
	
# 	if event.is_action_pressed("slash"):
# 		isPlay = true
# 		check_collision()
	


	# if event.is_action_pressed("slash"):
	# 	check_collision()

# func _input(event):
# 	if event.is_action_pressed("move_right"):
# 		_animated_sprite.set_flip_h(false)
# 		if Input.is_action_pressed("slash") &&  Input.is_action_pressed("move_right"):
# 			_animated_sprite.play("slash")
# 		else:
# 			_animated_sprite.play("walk")
# 	elif Input.is_action_pressed("move_left"):
# 		_animated_sprite.set_flip_h(true)
# 		if Input.is_action_pressed("slash") &&  Input.is_action_pressed("move_left"):
# 			#check_collision()
# 			_animated_sprite.play("slash")
# 		else:
# 			_animated_sprite.play("walk")
# 	elif Input.is_action_pressed("slash"):
# 		_animated_sprite.play("slash")
# 		count+=1
		
# 		# if $Raycast2D.is_colliding():
# 		# 	$Raycast2D.get_collider().die()
# 	else:
# 		_animated_sprite.play("default")
class slashStop extends Node2D:
	signal finished
	func _fixed_process(delta):
		if $AnimatedSprite.animation == "slash":
			print("here")
			emit_signal("finished")                                 
	func animation_done(): 
		print("here")
		$AnimatedSprite.play("default")		
