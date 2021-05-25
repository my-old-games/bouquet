extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var selected

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	live()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_TimerGrow_timeout():
	$AnimationPlayer.play("GROW")

func _on_TouchButtonTop_pressed():
	if selected:
		#queue_free()
		live()

func _on_TouchButtonBottom_pressed():
	selected = true

func live():
	var random = rng.randf_range(0.5, 2.0)
	$Sprite.frame = 0
	$TimerGrow.set_wait_time(random)
	$TimerGrow.start()
	selected = false
