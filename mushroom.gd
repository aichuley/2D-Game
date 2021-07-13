extends KinematicBody2D

var health = 100
var gravity = 50

onready var BULLET_SCENE = preload("res://Bullet.tscn")
var move = Vector2.ZERO
onready var _animated_sprite = $AnimatedSprite

var _player = null
var speed = 100


func _physics_process(delta):
	move = Vector2.ZERO
	if _player != null:
		move = position.direction_to(_player.position) * speed
	else:
		move = Vector2.ZERO

	move = move.normalized()
	move = move_and_collide(move)


func die():
	_animated_sprite.play("die")
	yield(_animated_sprite, "animation_finished")
	queue_free()
	# $World.score += 1
	get_node("/root/World").score += 1
	print(get_node("/root/World").score)


func hit():
	health -= 100
	if health <= 0:
		die()


func fire():
	var bullet = BULLET_SCENE.instance()
	bullet.position = get_global_position()
	bullet.player = _player
	get_parent().add_child(bullet)
	$Timer.set_wait_time(1)


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		print(body)
		_player = body


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		_player = null


func _on_Timer_timeout():
	if _player != null:
		fire()
