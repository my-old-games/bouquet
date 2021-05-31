extends CanvasLayer
# ---------------------- FUNCTIONS ----------------------
func _ready():
	$NPRModal.hide()

func showModal(win):
	if win:
		$NPRModal/VBCModal/CCTitle/LabelTitle.text = "Victory"
	else:
		$NPRModal/VBCModal/CCTitle/LabelTitle.text = "Game Over"
		$NPRModal/VBCModal/HBCButtons/ButtonNext.hide()
		$NPRModal/VBCModal/CCBouquet.modulate = Color(0,0,0)
	$NPRModal.show()

func set_flowers_count(score, tag):
	match tag:
		"F0":
			$HBCFlowers/VBCIconF0/MCLFlowerF0/LabelFloweF0.text = String(score)
		"F1":
			$HBCFlowers/VBCIconF1/MCLFlowerF1/LabelFloweF1.text = String(score)
		"F2":
			$HBCFlowers/VBCIconF2/MCLFlowerF2/LabelFloweF2.text = String(score)

func set_timer_count(seconds):
	$MCLTimer/NPRTimer/LabelTimer.text = String(seconds)

func set_theme(theme):
	$NPRTheme/MCLTheme/LabelTheme.text = theme

func basket_position():
	return $Basket.get_position()

func update_basket(anim):
	$Basket.set_animation(anim)

func hide_goals():
	$HBCFlowers.hide()

func _on_ButtonReset_pressed():
	get_tree().reload_current_scene()

func _on_ButtonHome_pressed():
	get_tree().change_scene("res://scenes/interface/main.tscn")

func _on_ButtonNext_pressed():
	get_tree().change_scene("res://scenes/interface/main.tscn")

func _on_ButtonQuit_pressed():
	get_tree().quit()
