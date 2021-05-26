extends Node2D

func set_animation(anim):
	$AnimatedSprite.play(anim)

func get_position():
	return position
