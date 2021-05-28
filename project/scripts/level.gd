extends Node2D
# ---------------------- EXPORTS ----------------------
export(Array, PackedScene) var flowers
export(int) var time
export(String) var theme
# ---------------------- ONREADY VAR ----------------------
onready var score = 0
onready var basket_position = $HUD.basket_position()
onready var trash_position  = $TestTrash.position
onready var holes = $Holes.get_children()
# ---------------------- VAR ----------------------
func _ready():
	$HUD.set_flowers_count(score)
	$HUD.set_timer_count(time)
	$HUD.set_theme(theme)
	generate_flowers()

func _picked_handler():
	score += 1
	$HUD.set_flowers_count(score)

func generate_flowers():
	for hole in holes:
		var flower = get_flower().instance()
		flower.reset_position = hole.position
		$Flowers.add_child(flower)

func get_flower():
	return flowers[0]

func update_basket():
	if  score > 0  and  score < 3 :
		$HUD.update_basket('ONE')
	elif score > 3 and  score < 5:
		$HUD.update_basket('HALF')
	elif score > 5:
		$HUD.update_basket('FULL')
	else:
		print("Fail!")

func _on_Clock_timeout():
	time -= 1
	$HUD.set_timer_count(time)
	if time == 0:
		$Clock.stop()
		print('GAME OVER')
