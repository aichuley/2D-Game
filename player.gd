extends KinematicBody2D

var gravity = 50
var acceleration = 3
var count = 0
var anim = "default"
var flag = false  # initialized outside process
var isAttacking = false
var health = 100

signal new_game

onready var raycast = $RayCast2D
# export (PackedScene) var raycast
var velocity = Vector2()
const MOVE_SPEED = 300
onready var _animated_sprite = $AnimatedSprite  #reference to player

func _ready():
	_animated_sprite.connect("animation_finished", self, "on_finished")
	# emit_signal("new_game")

#movement
func _physics_process(delta):
	var move_vect = Vector2()
	if isAttacking:
		_animated_sprite.play("slash")
	if Input.is_action_pressed("move_left"):
		if _animated_sprite.get_animation() == "slash":
			move_vect.x += 0
		else:
			move_vect.x -= 1
	if Input.is_action_pressed("move_right"):
		if _animated_sprite.get_animation() == "slash":
			move_vect.x += 0
		else:
			move_vect.x += 1
	if Input.is_action_pressed("move_up"):
		move_vect.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vect.y += 1
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y -= 600
		_animated_sprite.play("jump")
	move_vect = move_vect.normalized()
	velocity = velocity.linear_interpolate(move_vect * MOVE_SPEED, acceleration * delta)
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2(0, -1))


func _process(delta):
	if health <= 0:
		die()
	elif Input.is_action_pressed("move_right") && isAttacking == false:
		_animated_sprite.set_flip_h(false)
		raycast.cast_to = Vector2(-50, 0)
		_animated_sprite.play("walk")
	elif Input.is_action_pressed("move_left") && isAttacking == false:
		_animated_sprite.set_flip_h(true)
		_animated_sprite.play("walk")
		raycast.cast_to = Vector2(50, 0)
	elif Input.is_action_pressed("slash") && Input.is_action_pressed("move_left"):
		_animated_sprite.play("slash")
		# isAttacking = true
		_animated_sprite.play("jump")
	elif Input.is_action_pressed("slash") && Input.is_action_pressed("move_right"):
		_animated_sprite.play("walk")
		# isAttacking = true
	else:
		if isAttacking == false:
			_animated_sprite.play("default")

	if Input.is_action_pressed("slash"):
		isAttacking = true

func on_finished():
	if _animated_sprite.animation == "slash":
		isAttacking = false
		_animated_sprite.play("default")


func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.hit()
			print("hit " + collider.name)


func _input(event):
	if event.is_action_pressed("slash"):
		check_collision()

func die():
	_animated_sprite.play("death")
	yield(_animated_sprite, "animation_finished")
	queue_free()
	
func mushroom_hit():
	health -= 25
	print("PlayerHit" )
	print(health)


