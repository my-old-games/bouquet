extends Node2D
# ---------------------- FUNCTIONS ----------------------
func set_animation(anim):
	$AnimatedSprite.play(anim)

func get_position():
	return position
