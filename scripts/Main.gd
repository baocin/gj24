extends Node

@export var mob_scene: PackedScene
@export var cloud_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	$Player.hide()
	$Village.hide()
	#new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.score > Globals.villageProgression[0]:
		$Village.show()
	

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()


func new_game():
	$CloudTimer.start()
	$AudioStreamPlayer2D.play()
	Globals.gameTimeElapsed = 0
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Player.position = Vector2(500, 1000)
	$HUD.update_score(Globals.gameTimeElapsed)
	$HUD.show_message("Get Ready")
	$Background/AnimatedSprite2D.animation = "default"

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
func _on_score_timer_timeout():
	Globals.gameTimeElapsed += 1
	$HUD.update_score(Globals.gameTimeElapsed)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_hud_start_game():
	pass # Replace with function body.


func _on_cloud_timer_timeout():
	# Create a new instance of the Cloud scene.
	var cloud = cloud_scene.instantiate()

	# Choose a random location on Path2D.
	var cloud_spawn_location = $CloudPath/CloudSpawnLocation
	cloud_spawn_location.progress_ratio = randf()

	# Set the cloud's position to a random location.
	cloud.position = cloud_spawn_location.position

	# Set the cloud's direction to horizontal.
	var direction = PI
	cloud.rotation = direction

	# Choose the velocity for the cloud.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	cloud.linear_velocity = velocity.rotated(direction)

	# Spawn the cloud by adding it to the Main scene.
	add_child(cloud)
