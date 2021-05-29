extends CanvasLayer
# ---------------------- FUNCTIONS ----------------------
func set_flowers_count(score, tag):
	match tag:
		"F0":
			$HBCFlowers/VBCIconF0/MCLFlowerF0/LabelFloweF0.text = "x"+String(score)
		"F1":
			$HBCFlowers/VBCIconF1/MCLFlowerF1/LabelFloweF1.text = "x"+String(score)
		"F2":
			$HBCFlowers/VBCIconF2/MCLFlowerF2/LabelFloweF2.text = "x"+String(score)

func set_timer_count(seconds):
	$VBCThemeTimer/HBCThemeTimer/MCLTimer/LabelTimer.text = String(seconds)

func set_theme(theme):
	$VBCThemeTimer/HBCThemeTimer/MCLTheme/LabelTheme.text = theme

func basket_position():
	return $Basket.get_position()

func update_basket(anim):
	$Basket.set_animation(anim)
