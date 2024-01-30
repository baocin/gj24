extends RigidBody2D
signal collided

func _ready():
	#var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	#$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var random_num = randi() % 101
	if Globals.score < Globals.foodProgressionScore[0]:
		$AnimatedSprite2D.play("strawberry")
	elif Globals.score >= Globals.foodProgressionScore[0] and Globals.score < Globals.foodProgressionScore[1]:
		if random_num <= 50 + (Globals.score - 20):
			$AnimatedSprite2D.play("candy")
		else:
			$AnimatedSprite2D.play("strawberry")
	elif Globals.score >= Globals.foodProgressionScore[1] and Globals.score < Globals.foodProgressionScore[2]:
		if random_num <= 50 + (Globals.score - 20):
			$AnimatedSprite2D.play("candy")
		else:
			$AnimatedSprite2D.play("strawberry")
	elif Globals.score >= Globals.foodProgressionScore[2]:
		if random_num <= 33:
			$AnimatedSprite2D.play("candy")
		elif random_num > 33 and random_num <= 66:
			$AnimatedSprite2D.play("strawberry")
		else:
			$AnimatedSprite2D.play("cupcake")

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
