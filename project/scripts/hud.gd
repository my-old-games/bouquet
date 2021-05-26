extends CanvasLayer


func set_flowers_count(score):
	$VBoxContainer/HBoxContainer/Label2.text = String(score)

func set_timer_count(seconds):
	$VBoxContainer/HBoxContainer2/Label.text = String(seconds)

func basket_position():
	return $Basket.get_position()

func update_basket(anim):
	$Basket.set_animation(anim)
