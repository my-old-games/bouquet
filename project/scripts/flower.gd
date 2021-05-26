extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var selected

onready var root_level = get_parent().get_parent()

signal picked


# Called when the node enters the scene tree for the first time.
func _ready():
	if root_level != null and root_level.is_in_group("levels"):
		self.connect("picked", root_level, "_picked_handler")
		rng.randomize()
		live()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_TimerGrow_timeout():
	$AnimationPlayer.play("GROW")

func _on_TouchButtonTop_pressed():
	if selected:
		$AnimationPlayer.play("PICK")
		

func _on_TouchButtonBottom_pressed():
	selected = true

func live():
	var random = rng.randf_range(0.5, 2.0)
	$Sprite.frame = 0
	$TimerGrow.set_wait_time(random)
	$TimerGrow.start()
	selected = false

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"GROW":
			$AnimationPlayer.play("IDLE")
		"IDLE":
			$AnimationPlayer.play("WILT")
		"WILT":
			live()
		"PICK":
			emit_signal("picked")
			$Tween.interpolate_property(self, "position",
				self.position, root_level.basket_position, 1,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
		#live()

func _on_Tween_tween_completed(object, key):
	print(key)
