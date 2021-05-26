extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var selected

enum STATES {GROW, WILT, OK}
onready var flower_state = STATES.GROW
onready var root_level   = get_parent().get_parent()



signal picked

# Called when the node enters the scene tree for the first time.
func _ready():
	print(flower_state)
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
		match flower_state:
			0:
				$AnimationPlayer.play("PICK_BEFORE")
			1:
				$AnimationPlayer.play("PICK_AFTER")
			2:
				$AnimationPlayer.play("PICK")

func _on_TouchButtonBottom_pressed():
	selected = true

func live():
	var random = rng.randf_range(0.5, 4.0)
	$Sprite.frame = 0
	$TimerGrow.set_wait_time(random)
	$TimerGrow.start()
	flower_state = STATES.GROW
	selected = false

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"GROW":
			flower_state = STATES.OK
			$AnimationPlayer.play("IDLE")
		"IDLE":
			flower_state = STATES.WILT
			$AnimationPlayer.play("WILT")
		"PICK":
			emit_signal("picked")
			tween_start(root_level.basket_position)
		"PICK_AFTER":
			tween_start(root_level.trash_position)
		"PICK_BEFORE":
			tween_start(root_level.trash_position)
		"WILT":
			live()

func tween_start(target_position):
	$Tween.interpolate_property(self, "position",
								self.position, target_position, 1,
								Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	pass


