extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$TimerGrow.set_wait_time(rng.randf_range(0.5, 3.0))
	$TimerGrow.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TimerGrow_timeout():
	$AnimationPlayer.play("GROW")
