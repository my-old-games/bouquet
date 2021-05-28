extends CanvasLayer
# ---------------------- FUNCTIONS ----------------------
func set_flowers_count(score):
	$HBCFlowers/MCLFlower1/LabelFlowe1.text = "x"+String(score)

func set_timer_count(seconds):
	$VBCThemeTimer/HBCThemeTimer/MCLTimer/LabelTimer.text = String(seconds)

func set_theme(theme):
	$VBCThemeTimer/HBCThemeTimer/MCLTheme/LabelTheme.text = theme

func basket_position():
	return $Basket.get_position()

func update_basket(anim):
	$Basket.set_animation(anim)
