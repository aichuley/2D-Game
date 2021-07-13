extends Area2D

var move = Vector2.ZERO
var look_vector = Vector2.ZERO
var player = null
var speed = 3
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	look_vector = player.position - global_position
	
func _physics_process(delta):
	move = Vector2.ZERO
	move = move.move_toward(look_vector, delta)
	move = move.normalized() * speed
	position += move


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
