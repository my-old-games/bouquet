extends CanvasLayer


func set_flowers_count(score):
	$VBoxContainer/HBoxContainer/Label2.text = String(score)

func set_timer_count(seconds):
	$VBoxContainer/HBoxContainer2/Label.text = String(seconds)
