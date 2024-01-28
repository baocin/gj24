extends Area2D
signal hit
signal spawn_villager

var screen_size # Size of the game window.
@export var speed = 400 # How fast the player will move (pixels/sec).

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Globals.gameTime += delta;
	Globals.gameSteps += 1;
	
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	# cat pulse
	if (Globals.catPulseValue > 0 && Globals.score > 10):
		print(Globals.catPulseValue)
		$CatPulsePointLight.texture_scale += 1.2 * delta * Globals.catPulseValue;
		$CatPulsePointLight.texture_scale *= 1 + Globals.score/200;
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	


func _on_body_entered(body):
	body.hide()
	
	Globals.score += 1;
	print("Score", Globals.score)
	
	$ChompAudio.play()
	
	var random_num = randi() % 101
	if Globals.score > Globals.wowScoreProgression[0] and random_num < Globals.wowProbabilityProgression[0]:
		$WowAudio.play()
	elif Globals.score > Globals.wowScoreProgression[1] and random_num < Globals.wowProbabilityProgression[1]:
		$WowAudio.play()
	elif Globals.score > Globals.wowScoreProgression[2] and random_num < Globals.wowProbabilityProgression[2]:
		$WowAudio.play()
	elif Globals.score > Globals.wowScoreProgression[3] and random_num < Globals.wowProbabilityProgression[3]:
		$WowAudio.play()

	if Globals.score == Globals.wowScoreProgression[0]  || Globals.score == Globals.wowScoreProgression[1] || Globals.score == Globals.wowScoreProgression[2] || Globals.score == Globals.wowScoreProgression[3] || Globals.score == Globals.foodProgressionScore[0]:
		Globals.catPulseValue = float(1);
		$CatPulsePointLight.texture_scale = 0


	spawn_villager.emit()
	#if Globals.score > Globals.sceneColorProgression[0]:
		#$RigidBody2D.color


func _on_cat_soul_pulse_timer_timeout():
	pass
	
	
	
