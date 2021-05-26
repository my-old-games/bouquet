extends Node2D


var test_score = 0

func _ready():
	$HUD.set_flowers_count(test_score)

func _picked_handler():
	test_score = test_score + 1
	$HUD.set_flowers_count(test_score)
