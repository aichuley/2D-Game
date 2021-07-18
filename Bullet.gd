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
	

func check_collision():
	if $Area2D.is_colliding():
		var collider = $Area2D.get_collider()
		if collider.is_in_group("Player"):
			collider.hit()
			print("hit " + collider.name)
			
			
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.mushroom_hit()
		player = body


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		player = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
