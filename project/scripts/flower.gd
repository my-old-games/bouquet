extends Node2D
# ---------------------- EXPORTS ----------------------
export(String) var tag
export(float) var cooldown_min = 0.5
export(float) var cooldown_max = 7.0
# ---------------------- ENUMS ----------------------
enum STATES {GROW, WILT, OK}
# ---------------------- ONREADY VAR ----------------------
onready var flower_state = STATES.GROW
onready var root_level   = get_parent().get_parent()
# ---------------------- VAR ----------------------
var reset_position
var rng = RandomNumberGenerator.new()
var selected
# ---------------------- SIGNALS ------------------
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
	var random = rng.randf_range(cooldown_min, cooldown_max)
	position = reset_position
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
			reset_flower()

func tween_start(target_position):
	$Tween.interpolate_property(self, "position",
								self.position, target_position, 1,
								Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func reset_flower():
	hide()
	var random = rng.randf_range(0.5, 2.0)
	$TimerReset.set_wait_time(random)
	$TimerReset.start()

func _on_Tween_tween_completed(object, key):
	reset_flower()
	root_level.update_basket()

func _on_TimerReset_timeout():
	show()
	live()
	
	
