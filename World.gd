extends Node

export (PackedScene) var mob_scene
var score


func _ready():
	randomize()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("enemies", "queue_free")


func new_game():
	score = 0
	# $Player.start($StartPosition.position)
	$StartTimer.start()
	print("playing")
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	# score += 1
	$HUD.update_score(score)
	print(score)


func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation");
	mob_spawn_location.offset = randi()

	# Create a Mob instance and add it to the scene.
	var mob = mob_scene.instance()
	add_child(mob)

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	# direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# # Choose the velocity.
	var velocity = Vector2(rand_range(1, 5), 0)
	# mob.linear_velocity = velocity.rotated(direction)
