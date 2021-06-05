extends KinematicBody2D


var health = 100
var gravity= 50

onready var _animated_sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
# func _ready():
# 	if health <= 0:
# 		die()

		
func die():
	_animated_sprite.play("die")
	yield(_animated_sprite, "animation_finished")
	queue_free()

func hit():
	health -= 25
	if health <= 0:
		die()
